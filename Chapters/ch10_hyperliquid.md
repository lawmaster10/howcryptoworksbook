# Chapter X: Hyperliquid

This chapter examines Hyperliquid as a case study in how technical execution and aligned tokenomics can rapidly disrupt entrenched competitors. While Chapter VI covered the mechanics of perpetual futures and centralized exchange infrastructure, Hyperliquid represents a decentralized alternative that achieved remarkable market share through superior product design. Readers unfamiliar with perpetual futures mechanics (funding rates, mark price, liquidations) should review Chapter VI first, as this chapter assumes that foundation.

## Section I: Road to Domination

### The Rise of Hyperliquid

In 2025, a relatively unknown project had emerged from obscurity to dominate the **perp DEX** landscape. Hyperliquid's ascent was nothing short of extraordinary: monthly trading volume surged from negligible levels in 2023 to consistently exceeding $200 billion by the second half of 2025, reaching approximately 15% of Binance's perpetual volume. The platform attracted about $6 billion in bridged USDC collateral, making it one of DeFi's largest protocols by total value locked.

The November 2024 HYPE token airdrop catalyzed this growth. The genesis allocation reserved 31% of total supply for community distribution, though approximately 28% was ultimately claimed by over 90,000 users, with the remainder forfeited by those who did not sign the required terms and conditions. Points were earned primarily through mainnet trading activity across successive campaigns: an alpha season, hidden points seasons, and two public points seasons. Notably, the airdrop featured zero VC allocation. HYPE debuted at $2 and surged to nearly $60 by September 2025, a 30x appreciation driven by the token's unprecedented value capture mechanism: approximately 99% of trading fees flow directly into HYPE buybacks, transforming it from a governance token into a claim on protocol cash flows.

Perhaps most tellingly, by August 2024 Hyperliquid overtook dYdX, the established market leader with years of dominance, in monthly volume. By January 2025, the gap had become a chasm: Hyperliquid processed $200 billion while dYdX managed just $20 billion. This represented one of the most dramatic competitive reversals in DeFi history, with dYdX's market share collapsing from 75% in January 2023 to 7% by end of 2024, while Hyperliquid captured nearly 70%.

How did a newcomer achieve such dominance? The answer lies in a combination of competitor failures and Hyperliquid's own execution.

### Where Competitors Failed: The dYdX Collapse

dYdX's fall from dominance stems from strategic missteps that created an opening for disruption. Most critically, the project's tokenomics (the principles discussed in Chapter XII) offered token holders minimal value. The original v3 version, built on Ethereum scaling infrastructure, directed all trading fees to dYdX LLC with no direct benefit to token holders. Even after migrating to v4 as its own application-specific blockchain built on Cosmos, the fee structure remained problematic. Trading and gas fees flowed to validators and DYDX stakers in USDC, creating no buy pressure for the native token. When the buyback program finally launched in March 2025, likely in response to Hyperliquid, it only captured 25% of fees and staked the repurchased tokens rather than burning them, creating a much weaker value accrual mechanism than traditional buyback-and-burn models.

The stark contrast with Hyperliquid's approach is instructive. While dYdX's token offered little beyond governance rights, HYPE's aggressive fee-to-buyback mechanism created direct alignment between platform success and token value. Fee discounts stemmed primarily from volume and referral tiers rather than staking requirements alone, reducing friction for traders while maintaining strong token demand.

dYdX compounded its tokenomics failure with disastrous execution timing. The migration to v4 introduced user friction through complex bridging requirements and increased latency to \~1-second block times, precisely when performance became critical. The timing proved catastrophic, diverting critical resources to the overhaul just as Hyperliquid gained momentum with superior technology.

### Hyperliquid's Technical Edge

While dYdX struggled with its migration, Hyperliquid exploited the opening with breakthrough performance and relentless UX polish. Built as a custom L1 with a proprietary consensus mechanism, the platform achieved sub-second transaction finality with a median of 0.2 seconds. Most remarkably, it maintained a fully **on-chain order book**, something previously thought impossible without sacrificing performance. Unlike dYdX's hybrid approach, every bid, ask, and cancellation was recorded on-chain with transparent depth and zero gas fees for trading. **Session keys** enabled one-click trading by allowing users to pre-authorize a local signing key for a limited session, eliminating the need to confirm every order in a wallet popup and making the experience feel indistinguishable from a centralized exchange.

Two additional innovations helped Hyperliquid bootstrap liquidity before organic market-making arrived. The **Hyperliquidity Provider (HLP)**, a community-owned vault detailed in Section IV, provided baseline market-making and handled liquidations from day one, solving the cold-start liquidity problem that plagued other DEX launches. Hyperliquid also introduced **user-owned vaults**, originally built as a primitive for HLP and later opened to anyone, allowing traders to create public or private vaults that others could deposit into and follow, effectively crowdsourcing market-making strategies.

Superior user experience, aligned tokenomics, and technical performance combined to create a flywheel effect. Better execution attracted traders, higher volume drove token appreciation, token appreciation attracted more attention and capital, which generated more volume. By the time competitors recognized the threat, Hyperliquid had established an insurmountable lead.

The reversal demonstrates that in crypto's fast-moving markets, superior product-market fit can rapidly overcome established positions, even when incumbents enjoy years of advantage and institutional backing. But maintaining dominance requires addressing the challenges that come with scale.

## Section II: HyperBFT and EVM

That competitive success required custom infrastructure. The platform built **HyperCore**, a bespoke L1 blockchain that prioritizes performance and accessibility while making deliberate compromises around decentralization.

### Consensus Layer: HyperBFT

Hyperliquid initially launched on a Tendermint-based consensus engine before migrating to HyperBFT, a custom **Byzantine Fault Tolerant** design optimized for trading workloads. Permissionless validators and token staking were introduced later, after the HYPE token generation event.

HyperBFT achieves finality as long as more than two-thirds of validators remain honest. The system organizes block production through deterministic leader schedules, with epochs spanning roughly 100,000 rounds, or approximately 90 minutes.

This performance comes with inherent risks in leader-based systems. If a designated leader misbehaves or goes offline, they can temporarily censor transactions until the next rotation. While validator rotation and monitoring mitigate this risk, it represents a meaningful compromise compared to leaderless consensus mechanisms.

#### Validator Economics

To become an active validator, each participant must self-delegate at least 10,000 HYPE tokens. Active validators earn the right to produce blocks and receive rewards based on their total delegated stake.

Validators can charge delegators a commission on earned rewards. However, to protect delegators from exploitation, commission increases are strictly limited: validators can only raise their commission if the new rate remains at or below 1%. This prevents validators from attracting large amounts of stake with low commissions, then dramatically increasing fees to take advantage of unsuspecting delegators.

One-day delegation locks and seven-day unstaking periods balance validator commitment with capital liquidity, though these parameters involve their own tensions between security and flexibility.

### Execution Layer: HyperEVM

HyperEVM addresses the accessibility challenge by providing full EVM compatibility (the Ethereum Virtual Machine introduced in Chapter II), using HYPE as the native gas token. This allows existing Ethereum wallets, tools, and developer workflows to integrate seamlessly, a crucial factor for adoption.

#### HyperCore-HyperEVM Synergy: Dual Block Architecture

HyperEVM's power comes from how it runs alongside HyperCore under shared HyperBFT consensus, creating seamless interoperability between high-speed trading infrastructure and smart contract programmability.

HyperCore produces blocks with sub-second finality, optimized for order book operations and delivering \~200k orders per second. HyperEVM operates within the same global state but maintains its own **dual block architecture**: think of it like having two lanes on a highway, a fast lane with frequent small blocks every second (2M gas) for quick, lightweight interactions, and a slow lane with larger blocks roughly every minute (30M gas) for complex smart contract deployments. This separation allows optimization for both trading latency and smart contract throughput without forcing a compromise between speed and block size.

The layers coordinate sequentially. EVM contracts read HyperCore state from the previous Core block and enqueue actions that execute in subsequent Core blocks, creating a controlled, structured interaction rather than arbitrary cross-calls.

The key innovation lies in the communication mechanism between these environments. Special built-in functions expose HyperCore's native state directly to EVM contracts, providing access to perpetual positions, spot balances, vault equity, staking data, and oracle prices, all synchronized to the latest Core block. A dedicated system contract enables the write path, allowing contracts to enqueue well-defined actions: placing orders, managing positions, transferring collateral, and adjusting staking. While reads are synchronous, write actions are processed asynchronously in later Core blocks, giving HyperCore control over execution timing and risk management.

Such architecture unlocks applications impossible on traditional DEXs. Developers can build vaults that dynamically adjust perpetual positions based on real-time prices and equity thresholds, or automated strategies that respond to liquidation events and funding rate changes. All of this is done through familiar Solidity code that delegates actual trade execution and risk accounting to HyperCore.

**Asset linking** extends this integration to liquidity itself. Each HyperCore spot asset can be linked to an ERC-20 on HyperEVM through asset bridge contracts at special `0x200...` addresses. Once linked, moving assets between Core and EVM requires no wrapped tokens or separate bridge contracts. It's just standard transfers. The same USDC or HYPE supply flows freely between Core trading and EVM DeFi without fragmentation or conversion steps.

The dual-layer architecture between HyperCore and HyperEVM has also enabled arbitrage activity around Unit-bridged assets. Arbitrageurs exploit price differences between assets on HyperCore's trading layer and their linked representations on HyperEVM, with this activity visible in on-chain analytics. This arbitrage serves an important function: it helps keep prices synchronized between the layers and provides liquidity depth, though it also highlights the complexity of maintaining price coherence across multiple execution environments.

Consider native liquid staking as an example of what this enables. Protocols like Kinetiq use these built-in read functions to track validator performance and staking state, while write functions handle delegation and rebalancing operations. When users stake HYPE through Kinetiq, the protocol stakes on HyperCore validators while issuing kHYPE tokens on HyperEVM. This is similar to how liquid staking works on Ethereum (Chapter II), where users receive tradeable tokens representing their staked position. Those tokens participate in lending markets, AMMs, and structured products while the underlying HYPE continues earning staking rewards and securing the network. This happens without the fragmentation typical of systems where liquid staking tokens exist on separate layers from the base staking mechanism.

This design represents a deliberate choice: provide full EVM tooling with privileged access to high-performance infrastructure, rather than forcing developers into unfamiliar environments. The trade-off is increased complexity and a broader attack surface. Contracts with write access can trigger real trading actions on HyperCore, requiring careful security around permission models. Hyperliquid mitigates this by constraining the system to a structured set of actions, rolling out features gradually, and strongly incentivizing audits for any contract that can enqueue Core operations.

#### Builder Codes: Incentivizing Front-End Development

Most crypto exchanges tightly control their interfaces, capturing all trading fees while forcing users through a single gateway. Hyperliquid takes the opposite approach: **Builder Codes** allow third-party developers to create custom trading platforms that earn fees from the activity they generate.

Developers attach unique identifiers to transactions routed through their interfaces. When users trade through these platforms, builders earn an additional fee of up to 0.1% on perpetual trades and 1% on spot trades, creating direct economic alignment: better interfaces generate more volume, which means more revenue. Developers compete on user experience rather than extracting rent through proprietary access.

Phantom Wallet integrated Builder Codes in July 2025, enabling native perpetual trading without leaving the wallet environment. In under six months, it's generated approximately $10 million in total revenue, with daily earnings now approaching $100,000. Rabby, MetaMask, and Axiom have followed with their own integrations. Based.one, a trading super-app built on Hyperliquid and backed by Ethena Labs, created a custom interface on the protocol's infrastructure.

The ecosystem impact has been substantial. Builder Code integrations have generated over $100 billion in additional perpetual volume, with developers collectively earning nearly $40 million. These figures demonstrate how fee-sharing can bootstrap front-end diversity without fragmenting liquidity.

By unbundling the interface layer from the protocol and creating explicit incentives for third-party development, Hyperliquid effectively crowdsources both user acquisition and interface innovation. Third-party frontends can also iterate on UX faster than the core team: several already offer private TWAPs and advanced order types unavailable on the main Hyperliquid interface. The trade-off? Reduced direct revenue capture and the risk that inferior interfaces could damage user experience. Market competition and fee-based filtering should naturally select for quality over time.

#### Collateral System

USDC serves as collateral on Hyperliquid. All perpetual positions use USDC as collateral, creating a unified margin system that simplifies risk management and capital efficiency. The platform has attracted nearly $6 billion in bridged USDC from Arbitrum.

In September 2025, Circle announced it would launch a native version of USDC on Hyperliquid, starting with the HyperEVM network and expanding to HyperCore later. Circle also invested in HYPE tokens, making it a direct stakeholder in the platform. This development comes shortly after Hyperliquid held a competition to select an issuer for its native USDH stablecoin, which was won by Native Markets.

The arrival of native USDC on HyperEVM has a meaningful structural implication for the Arbitrum bridge. As native USDC becomes the dominant form of collateral on HyperCore, the earlier bridged USDC from Arbitrum, which depends on a permissioned 3-of-4 validator multisig, can be gradually deprecated. Over time this reduces the system's reliance on that concentrated withdrawal mechanism and shifts the collateral base toward a more direct, Circle-backed issuance model.

## Section III: Tradable Products

Hyperliquid's technical architecture enables three distinct trading products, each with different risk profiles and listing mechanisms.

Hyperliquid offers perps (standard perpetual futures), **hyperps** (pre-launch perps that use internal pricing instead of external oracles), and spot trading on fully on-chain order books. The platform also supports permissionlessly deployed perps (HIP-3), with outcome markets (HIP-4) announced but not yet live.

Listing mechanisms vary by product type. Spot listings require winning **Dutch auctions**, where the price starts high and decreases until someone buys, to deploy HIP-1 tokens on HyperCore, then creating trading pairs through additional auctions. Perp listings can now be deployed permissionlessly via HIP-3, subject to staking requirements detailed in Section VI. Hyperps remain curated and are specifically designed for assets without reliable external price feeds.

### Bridging and Asset Representation

All spot assets trade as HIP-1 tokens on HyperCore's L1, regardless of origin. When users deposit BTC or SOL, it becomes a HIP-1 representation that trades on the on-chain order book and can be withdrawn back to native blockchains.

The bridging process varies by asset. Non-USDC assets like Bitcoin, Ethereum, and Solana bridge through Unit's **lock-and-mint** guardian system, while USDC from Arbitrum uses Hyperliquid's own validator-run bridge. For Bitcoin, users send native BTC managed by Unit's guardian network. Once confirmed, Unit mints the corresponding HIP-1 token (UBTC) on HyperCore for trading. Withdrawals reverse this: the HIP-1 token burns and Unit releases the native BTC.

Unit occupies an unusual position. While technically separate, it functions as Hyperliquid's native tokenization layer, similar to how bridges work across other blockchains (Chapter IV's interoperability section). The system runs on a 2-of-3 guardian quorum: Unit, Hyperliquid, and infrastructure firm Infinite Field. From a user's perspective, clicking "Deposit BTC" provides a Unit-controlled address, and BTC appears on the same order book as everything else. Major pairs like BTC/USDC and ETH/USDC now clear billions in cumulative volume.

Unit's economic model resembles an embedded module rather than a neutral bridge. It charges per-transfer fees and earns trading fees from spot markets, with integration packages reportedly costing seven figures for new assets. This creates a two-tier system: Unit-integrated assets get privileged placement in Hyperliquid's native deposit interface, while others require external bridges.

Alternatives have emerged. LayerZero integrated HyperEVM as a first-class endpoint, powering "The Hyperliquid Bridge" that moves tokens from 120+ chains. Projects like Flare and Mantle deploy as LayerZero OFTs (Omnichain Fungible Tokens, a standard for tokens that can move between chains) and connect to HIP-1 tickers on HyperCore, creating CEX-like 1:1 deposits without AMM slippage. Orchestration layers like Monarch help projects permissionlessly deploy markets and bridging without Unit integration, though these typically operate through external UIs rather than Hyperliquid's built-in interface.

The bridge architecture creates security considerations. Withdrawals depend on a permissioned 4-validator set on Arbitrum with a 3-of-4 signature threshold, concentrating withdrawal authority rather than relying on broader L1 consensus. This creates potential risks around fund security and censorship if validators collude or become unavailable.

### Hyperps: Pre-Launch Trading

Beyond bridged spot assets, Hyperliquid offers a more speculative product class called hyperps. Hyperps are used primarily for trading perps of tokens before they are launched, either to speculate or hedge the price of farmed proceeds. Hyperp prices remain more stable and resist manipulation compared to standard pre-launch futures. The system also provides greater flexibility; the underlying asset or index only needs to exist when the contract settles or converts, not throughout the entire trading period.

Funding rates (the mechanism explained in Chapter VI) play a crucial role in hyperp trading. When prices move strongly in one direction, the funding mechanism will heavily incentivize positions in the opposite direction for the following eight hours. This creates both opportunities and risks that traders must account for.

In August 2025, four coordinated whales executed market manipulation on Hyperliquid's XPL hyperps, profiting approximately $15M while causing over $20M in user liquidations. The attack exploited Hyperliquid's reliance on a thin, isolated spot price feed by using just $184k to artificially inflate XPL's spot price nearly eightfold, which caused the futures price to spike from $0.60 to $1.80 in minutes and triggered cascading liquidations of short positions. While technically not an exploit since it operated within the protocol's design, the attack exposed critical vulnerabilities in hyperps. This prompted Hyperliquid to implement emergency safeguards including 10x price caps.

### Liquidation Transparency and Risks

Full on-chain verifiability means positions and liquidation thresholds can sometimes be inferred from public state and trading behavior. While that visibility improves auditability and market integrity, it also makes clustered liquidations easier to target: adversaries can strategically push mark prices through known liquidity-light levels to trigger cascades, imposing outsized losses on passive participants. These liquidation risks fall heavily on HLP depositors, as we'll see in the next section. Mitigations include tighter per-asset risk limits and position caps, anti-manipulation bands around liquidation prices, staggered or batched liquidation flows, and circuit breakers.

## Section IV: The HLP Design

With tradable products in place, Hyperliquid faced another challenge: ensuring the liquidity depth necessary for these markets to function. Technical performance alone doesn't guarantee success; traders demand deep liquidity, tight spreads, minimal slippage, and reliable liquidation mechanisms, requirements that have historically favored centralized exchanges with dedicated market makers. Hyperliquid's solution creates new compromises between liquidity provision and risk concentration.

The **Hyperliquidity Provider (HLP)** represents Hyperliquid's most innovative design choice: a community-owned vault that simultaneously provides market-making services and handles liquidations. Depositors contribute capital to HLP and share in its profit and loss, creating a decentralized market-making system that doesn't rely on external firms. HLP's profits come primarily from market-making spreads and liquidation fees, while losses stem from being on the wrong side of trades against sophisticated traders who possess better information or faster execution, as well as from holding losing positions as the counterparty to winning trades.

HLP's design solves several problems at once. It provides consistent liquidity across all markets, handles liquidations efficiently (crucial for leveraged trading), and distributes market-making profits to the community rather than extracting them to external firms. The system internalizes much of the trading flow, reducing the need for external counterparties.

However, this concentration creates meaningful risks. During extreme volatility, HLP depositors bear the losses from trading against better-informed counterparties and from liquidation cascades. It is also worth noting that HLP now accounts for a small minority of daily trading volume, roughly 1-2%, as organic market-maker participation has grown. While HLP isn't the sole counterparty on the **central limit order book** (anyone can post liquidity), it provides core baseline liquidity across markets and performs liquidations, creating concentration risk that traditional market-making structures distribute across multiple firms.

### The JELLY Manipulation

The JELLY manipulation in March 2025 demonstrated how vault-based systems can suffer losses from coordinated attacks. Attackers opened large leveraged positions ($4.5M short, two $2.5M longs) on a low-liquidity token JELLY, then manipulated the liquidation process while simultaneously pumping the token's price 250% on Solana. This created a $12 million unrealized loss that threatened the protocol's solvency. Validators had to make an emergency intervention, overriding the oracle price to prevent collapse, while the team quickly implemented fixes including better position size limits, improved liquidation mechanisms, and enhanced governance controls. All traders were compensated, but the incident exposed significant vulnerabilities in the platform's risk management architecture.

### The October Liquidation Cascade

The October 10 liquidation cascade was the largest stress test of infrastructure. Over $20 billion in leveraged positions were liquidated, and total outstanding perpetual contracts across the market collapsed by 43%. Hyperliquid processed roughly half of all liquidations. Its outstanding positions fell from $14 billion to $6 billion while maintaining 100% uptime and avoiding bad debt.

HLP performed as designed. When the order book couldn't absorb forced selling, HLP's liquidation child vaults stepped in as backstop liquidators. They took over distressed positions plus collateral and unwound into the rebound. Across the event, HLP generated over $40 million in profit, roughly a 10% daily return on vault capital. This was driven largely by liquidation flow during the cascade.

The violence also triggered Hyperliquid's cross-margin **auto-deleveraging** mechanism (the backstop process explained in Chapter VI) for the first time in over two years. HLP is compartmentalized into child vaults with isolated risk limits, so some liquidation vaults themselves approached negative equity as they warehoused junk exposure. At that point, after regular liquidations and HLP takeovers were exhausted for those specific accounts, the risk engine began trimming profitable positions on the winning side. It used a documented ranking system to keep every margin account non-negative by forcibly closing the most profitable positions first. The result: LP capital backstopped the system and still booked outsized net returns with no bad debt. This occurred even though some profitable shorts, including large external traders and HLP child vaults, were forcibly reduced at locally optimal prices.

Different vault designs absorbed tail risk differently. On Lighter, a competing perpetual DEX examined in Section VII, the LLP vault provides most day-to-day liquidity. When the market gapped and its infrastructure suffered multi-hour outages, LLP took the hit directly. It suffered roughly a 5.3% drawdown, about $21.5 million in losses, while traders unable to manage positions lost $25 to $30 million more. Lighter later compensated via a points program. The structural contrast is clear: HLP is a high-capacity, compartmentalized backstop that turns volatility into yield, while LLP functions as always-on inventory taking first-loss risk.

## Section V: The Decentralization Challenge

While HLP's design has proven resilient under stress, the vault mechanism itself operates within a broader infrastructure that involves its own set of trade-offs, particularly around decentralization. While Hyperliquid's technical performance enabled its rapid growth, that execution efficiency required calculated centralization choices. Understanding these limitations is essential for evaluating the platform's long-term viability.

### Validator Control and Operations

The most prominent concern centers on validator control, where the Hyper Foundation controls approximately 80% of staked HYPE through its own validators. The Foundation serves as the protocol's primary steward, responsible for core development, infrastructure maintenance, and ecosystem grants, while holding significant token reserves to fund long-term operations. This concentration could theoretically allow a single entity to halt or steer the chain, raising questions about censorship resistance.

The validator experience itself has drawn significant scrutiny. The protocol relies on closed-source node software, forcing validators to run what critics describe as a "single binary" with limited documentation. Validators have publicly complained that this arrangement creates a "blind signing" scenario where they cannot inspect the code they're running, leading to frequent jailing incidents and making it difficult to assess risks independently. The validator selection process has also faced criticism for being opaque, with reports of low rewards relative to self-bonding requirements and the emergence of a testnet HYPE black market.

### Infrastructure Dependencies

Infrastructure dependencies present additional risks that have manifested in real-world disruptions. Hyperliquid's architecture relies heavily on centralized APIs for both validator operations and user access. Validators reportedly need to call Hyperliquid-operated APIs to recover from jailing, while users depend on these same API servers to submit transactions and access market data. This dependency became acutely apparent during a July 2025 incident when API traffic spikes caused 37 minutes of trading disruption, effectively freezing user interactions despite the underlying blockchain continuing to produce blocks.

### The Path Forward

Hyperliquid has acknowledged these concerns and indicated plans to open-source code and decentralize infrastructure over time. The current architecture reflects a strategic choice to prioritize rapid iteration and security hardening in the protocol's early stages, gradually relinquishing control as the system demonstrates resilience at scale.

## Section VI: The Governance Balance

Despite these centralization trade-offs, Hyperliquid has developed governance mechanisms that enable permissionless expansion while maintaining quality and managing risk. Rather than relying solely on centralized curation, the protocol uses economically-enforced quality controls that align incentives through stake requirements and fee sharing.

**Hyperliquid Improvement Proposals (HIPs)** govern platform evolution, with each proposal addressing specific aspects of permissionless expansion:

HIP-1 established a native token standard with a 31-hour Dutch auction mechanism, allowing anyone to list spot tokens. This democratizes token launches while setting deployment costs through market-driven price discovery, which raises the bar for low-quality launches since the auction format naturally selects for tokens with genuine demand.

HIP-2 introduced automated "Hyperliquidity" for spot pairs against USDC, ensuring baseline liquidity for newly listed HIP-1 tokens. This solves the chicken-and-egg problem where tokens need liquidity to attract traders, but they need traders to justify liquidity provision.

HIP-3 launched permissionless perpetual markets, subject to a 500k HYPE staked requirement by the deployer. Builders receive a share of fees in return. This creates strong incentives for responsible listings while generating meaningful cost for spam or low-quality markets.

HIP-4 extends the platform's product scope to outcome markets, covering options and prediction markets. Announced but not yet live at time of writing, it represents the next frontier of permissionless financial primitives on Hyperliquid.

The staking requirement effectively limits perpetual launches to serious participants while aligning their incentives with market success. However, builders face validator-driven delisting and potential stake slashing for malicious or unsafe operation, effective for quality control but can discourage experimentation.

The governance structure reflects how protocols can decentralize without sacrificing quality: economic stakes create market-driven curation where builders must justify capital allocation upfront. Pure permissionlessness leads to noise and poor user experience; high barriers ensure serious participants while potentially discouraging experimentation. It's a calculated compromise that prioritizes ecosystem quality over absolute openness.

## Section VII: Emerging Competitors

Hyperliquid's dramatic rise validated the perpetual DEX thesis and painted a target on its back. The broader sector has since expanded dramatically, surpassing $1 trillion in monthly trading volume across more than twenty competing protocols by early 2026\. This explosive growth has attracted both capital and competitive scrutiny. Established projects have pivoted toward perps, while well-funded newcomers have launched with differentiated strategies designed to challenge the leader.

More significantly, perpetual DEXs are capturing an expanding share of overall derivatives volume relative to centralized exchanges. While exact percentages fluctuate with market conditions and incentive cycles, the trend reflects a structural shift in trader preferences. Several factors drive this migration. Aggressive incentive programs have drawn significant speculative capital that prioritizes token farming over pure trading efficiency. The anticipation of follow-on airdrops, including widespread speculation about a second Hyperliquid distribution, amplifies this effect. Traders are chasing yield opportunities that extend beyond simple trading profits, creating powerful network effects as volume begets more incentives, which in turn attracts more volume-seeking participants.

The maturation of DEX technology itself has narrowed the execution gap. When perpetual DEXs can match CEX latency and depth while offering non-custodial security and token rewards, the switching costs diminish substantially. Perhaps most tellingly, the same risk appetite that fueled memecoin speculation appears to be rotating into leveraged perpetual trading. Traders seek similar volatility and leverage but with more liquid exit paths and established infrastructure. This capital rotation isn't random but reflects rational optimization: perpetual trading offers the same high-octane speculation as memecoins but with deeper liquidity, more sophisticated tooling, and the added benefit of farming anticipated token distributions.

The convergence of incentives, infrastructure maturity, and capital rotation suggests that perpetual DEX growth isn't merely riding overall crypto market expansion. It's actively claiming market share from centralized platforms.

### Lighter: Verifiable Security Architecture

Lighter markets itself as the security-first alternative, built on Ethereum with cryptographic proofs that mathematically verify every order match and liquidation is executed correctly. The protocol launched its public mainnet in early October 2025 on an Ethereum L2, with user collateral remaining custodied on Ethereum itself, a design choice detailed in its whitepaper that prioritizes asset security over raw performance. Lighter positions itself as the first exchange to offer verifiable matching and liquidations, a security focus supported by external audits including zkSecurity's circuit audit and recent Nethermind Security audits covering core contracts and bridge infrastructure.

The platform's fee structure targets retail traders: standard users trading through the front end pay zero maker and taker fees, while API access and high-frequency trading flow incur charges. Funding payments remain peer-to-peer between longs and shorts rather than platform fees. This fee structure appeals to institutional and risk-conscious traders who prioritize verifiable safety in a landscape where, as perpetual DEXs achieve CEX-like responsiveness and deeper liquidity, attack surfaces expand proportionally. In this context, cryptographic verification becomes a competitive differentiator rather than merely a baseline feature.

### Aster: The Binance-Connected Challenger

Aster takes a markedly different approach, emerging from the merger of Astherus and APX Finance with backing from YZi Labs (CZ's venture firm) and CZ serving in an advisory capacity. Binance has clarified it holds no official role, though the connection to its founder and former executives provides significant credibility and network effects.

The platform's business model combines competitive fee structures (starting around 0.01% maker and 0.035% taker with VIP tiering and a 5% discount for paying fees in $ASTER tokens) with the "Trade and Earn" model that allows yield-bearing assets like USDF (Aster's own fully-collateralized stablecoin, with variable APY promoted around 17% during Season 2\) and asBNB to serve directly as collateral.

Product features target diverse trader segments. Hidden Orders conceal position sizes for privacy-conscious traders, while dual trading modes serve both novices (Simple mode with up to 1001× leverage) and professionals (Pro mode with advanced tools). Beyond crypto perpetuals, Aster has expanded into leveraged stock perpetuals in Pro mode, broadening its addressable market.

Reported metrics suggest significant traction: approximately $500 billion in cumulative volume, fees of over $110 million, and 1.8 million user addresses. However, these figures warrant scrutiny. DefiLlama temporarily delisted Aster's perpetual volumes amid concerns about artificial volume inflation, where traders buy and sell to themselves to inflate metrics, and data quality debates remain ongoing. The platform operates with a hybrid architecture (off-chain matching engine paired with on-chain settlement) that enables faster execution while maintaining non-custodial asset security, though it may limit appeal to DeFi purists seeking fully decentralized infrastructure.

Aster continues to run intensive incentive campaigns, with its Dawn points program (Stage 3 currently live) designed to bootstrap liquidity and user adoption.

