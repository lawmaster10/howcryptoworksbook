WITH
  -- token constants (varbinary is already case-insensitive)
  token_constants AS (
    SELECT 
      from_hex('a0b86991c6218b36c1d19d4a2e9eb0ce3606eb48') AS usdc_addr,
      from_hex('dac17f958d2ee523a2206206994597c13d831ec7') AS usdt_addr
  ),
  -- canonical pool whitelists
  uni_v3_pools(pool_address, label) AS (
    VALUES
      (from_hex('3416cf6c708da44db2624d63ea0aaef7113527c6'), 'Uniswap V3 USDC/USDT (0.01%)'),
      (from_hex('7858e59e0c01ea06df3af3d20ac7b0003275d4bf'), 'Uniswap V3 USDC/USDT (0.05%)')
  ),
  curve_pools(pool_address, label) AS (
    VALUES
      (from_hex('bebc44782c7db0a1a60cb6fe97d0b483032ff1c7'), 'Curve 3Pool (USDC/USDT legs)'),
      (from_hex('4f493b7de8aac7d55f71853688b1f7c8f0243c85'), 'Curve USDC/USDT (Stableswap NG)')
  ),
  trades_2023_2025 AS (
    SELECT
      tr.*,
      uv3.label AS uv3_label,
      cp.label AS cp_label,
      tc.usdc_addr,
      tc.usdt_addr
    FROM dex.trades AS tr
    CROSS JOIN token_constants tc
    LEFT JOIN uni_v3_pools AS uv3
      ON tr.project_contract_address = uv3.pool_address
    LEFT JOIN curve_pools AS cp
      ON tr.project_contract_address = cp.pool_address
    WHERE tr.blockchain = 'ethereum'
      AND tr.block_time >= TIMESTAMP '2023-01-01'
      AND tr.block_time < TIMESTAMP '2025-10-01'
      AND (
        -- Uniswap v3: only on canonical USDC/USDT pools
        (
          tr.project = 'uniswap'
          AND tr.version = '3'
          AND uv3.pool_address IS NOT NULL
          AND (
            (tr.token_bought_address = tc.usdc_addr AND tr.token_sold_address = tc.usdt_addr)
            OR
            (tr.token_bought_address = tc.usdt_addr AND tr.token_sold_address = tc.usdc_addr)
          )
        )
        OR
        -- Uniswap v4: singleton architecture; strict token filter
        (
          tr.project = 'uniswap'
          AND tr.version = '4'
          AND (
            (tr.token_bought_address = tc.usdc_addr AND tr.token_sold_address = tc.usdt_addr)
            OR
            (tr.token_bought_address = tc.usdt_addr AND tr.token_sold_address = tc.usdc_addr)
          )
        )
        OR
        -- Curve: only whitelisted pools, USDC<>USDT legs
        (
          tr.project = 'curve'
          AND cp.pool_address IS NOT NULL
          AND (
            (tr.token_bought_address = tc.usdc_addr AND tr.token_sold_address = tc.usdt_addr)
            OR
            (tr.token_bought_address = tc.usdt_addr AND tr.token_sold_address = tc.usdc_addr)
          )
        )
      )
  ),
  monthly_aggregates AS (
    SELECT 
      date_trunc('month', block_time) AS month,
      CASE 
        WHEN project = 'uniswap' THEN 'Uniswap (USDT-USDC)'
        WHEN project = 'curve' THEN 'Curve (USDT-USDC)'
      END AS protocol,
      SUM(
        COALESCE(
          amount_usd,
          -- Fallback: convert raw token amounts to USD (USDC/USDT both have 6 decimals)
          CASE
            WHEN token_bought_address = usdc_addr THEN token_bought_amount / 1e6
            WHEN token_sold_address = usdc_addr THEN token_sold_amount / 1e6
            WHEN token_bought_address = usdt_addr THEN token_bought_amount / 1e6
            WHEN token_sold_address = usdt_addr THEN token_sold_amount / 1e6
            ELSE 0
          END,
          0
        )
      ) AS monthly_volume
    FROM trades_2023_2025
    GROUP BY 1, 2
  )
SELECT 
  month,
  protocol,
  monthly_volume,
  CASE protocol
    WHEN 'Uniswap (USDT-USDC)' THEN '#ff007a'  -- pink
    WHEN 'Curve (USDT-USDC)' THEN '#ffcc00'    -- yellow
  END AS color_hex
FROM monthly_aggregates
WHERE protocol IS NOT NULL
ORDER BY month, protocol;