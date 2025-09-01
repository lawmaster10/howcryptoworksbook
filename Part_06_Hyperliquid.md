# Part VI: Hyperliquid

## Chapter 21: The Hyperliquid Ecosystem

### Industry Context: Decentralized Perps & Competitors

The decentralized perpetuals market has evolved in waves. **Synthetix** pioneered the category with on-chain synthetic perps, but its pooled-debt AMM design, oracle dependencies, and latency/frictions limited professional trader adoption. **dYdX** then popularized decentralized orderbook perps, but its shift off Ethereum (to an appchain) fragmented liquidity and changed incentives/UX; as newer venues prioritized lower latency, deeper long-tail listings, and maker-friendly microstructure, dYdX’s share slipped. **GMX** briefly led with an AMM-and-vault model (GLP) and simple UX, yet inventory constraints and oracle-driven funding limited scale in highly volatile regimes. The market subsequently consolidated around high-performance, vertically integrated CLOBs—setting the stage for **Hyperliquid**.

Today, the largest direct competitor to Hyperliquid is **Lighter**, which similarly targets low-latency, orderbook-based perps for professional flow. Beyond Lighter, a growing set of perps DEXs experiment with AMM–orderbook hybrids and appchain rollups, but the trend has been toward speed, capital efficiency, and permissionless listings—areas where Hyperliquid has differentiated.

**Hyperliquid** is a high-performance decentralized derivatives exchange designed to compete with the speed and efficiency of centralized platforms. It achieves this by operating on its own purpose-built **Layer 1 blockchain**, **HyperCore**, which is meticulously optimized for a single function: running an on-chain **Central Limit Order Book (CLOB)**. This vertically integrated approach, from consensus to execution, is the primary source of its speed.

### Platform Architecture & Consensus

The foundation of Hyperliquid is its bespoke L1 blockchain, **HyperCore**. The matching engine is embedded directly into this consensus layer, enabling extremely fast and optimized trade execution. The network is secured by a consensus mechanism called **HyperBFT**, which is inspired by the **HotStuff protocol** and operates in epochs of **100,000 rounds** (approximately 90 minutes).

To ensure developer and user accessibility, the platform features **HyperEVM**, making it fully compatible with the **Ethereum Virtual Machine**. This allows for seamless integration with existing DeFi wallets and tools, with **HYPE** serving as the native gas token.

#### Validator Requirements and Staking
Validators play a crucial role in securing the network. They are required to have a minimum self-delegation of **10,000 HYPE**. Staked tokens have a **1-day lockup period** and a **7-day unstaking period**. The staking reward rate is approximately **~2.37% APR** and follows a model similar to Ethereum's, where the yield is inversely proportional to the total amount of HYPE staked across the network.

As a **BFT family protocol**, HyperBFT targets fast finality under the assumption of **>2/3 honest voting power**; leader-based scheduling can introduce temporary censorship risks if a leader misbehaves.

### Trading Infrastructure & Liquidity

Hyperliquid's trading environment is defined by several unique components:

#### Hyperliquidity Provider (HLP)
This is the protocol's **native liquidity vault**. Users can deposit assets into the HLP, which then acts as the **single counterparty for all trades** on the exchange. It functions as an automated market maker and also manages all liquidations, capturing fees that would otherwise go to third-party liquidators and distributing them to the vault's depositors.

#### Collateral and Leverage
- **Primary collateral** for perpetual contracts is **USDC**, which provides a unified USD-based margin system
- The platform offers up to approximately **40x leverage**, depending on the specific asset

#### "Hyperps" (Hyperliquid Perpetuals)
These are Hyperliquid-specific perpetual contracts that use an innovative **funding rate mechanism**. Instead of relying on external spot or index oracle prices, funding rates are calculated based on an **8-hour moving average** of the contract's own mark price (no external spot oracle). This design significantly reduces the risk of oracle manipulation.

Order types include **limit and market orders** with **price-time priority**; on-chain visibility can create mempool-to-book latency arbitrage risks in volatile periods.

**Margining** commonly supports **cross and isolated modes**; maintenance margin breaches trigger liquidations. **HLP capital** absorbs liquidation flow; extreme volatility can lead to drawdowns for HLP depositors.

### Bridging and Asset Support

The **HyperUnit Bridge** serves as the platform's native asset tokenization layer, facilitating deposits and withdrawals. A key feature of this infrastructure is its ability to support **native BTC, ETH, and SOL** without requiring wrapped tokens, which greatly simplifies the user experience. This bridge has proven to be robust, having processed over **$112M in BTC** and **$21M in ETH** in net inflows.

Its architecture is built on a **decentralized Guardian network** that uses a **Multi-Party Computation (MPC) Threshold Signature Scheme** with a **2-of-3 consensus model** for security.

A small **2-of-3 TSS quorum** concentrates trust compared to light-client bridges; operators may implement pauses or limits during incidents to preserve safety.

### Governance and Permissionless Innovation

The platform evolves through **Hyperliquid Improvement Proposals (HIPs)**, which have progressively opened the ecosystem to permissionless activity.

#### HIP-1
Established a **native token standard** and a unique deployment method via a **31-hour Dutch auction**. This allows anyone to permissionlessly list a new spot token.

#### HIP-2
Introduced an **automated market-making system** that provides baseline liquidity for new HIP-1 tokens, typically with a **0.3% spread**.

#### HIP-3
Transformed Hyperliquid into a truly **permissionless infrastructure** by allowing anyone to deploy their own perpetual markets. To do so, a builder must stake **1 million HYPE**, and in return, they can earn up to **50% of the trading fees** from their market.

Builders should consider **market delisting/offboarding risk** if liquidity or risk thresholds are breached; staked HYPE aligns incentives for responsible listings.

### Tokenomics: The HYPE Token

The **HYPE token** is central to the ecosystem's value accrual. A substantial **93% of all protocol fee revenue** is used to systematically buy HYPE tokens from the open market. This creates a direct link between platform trading volume and buy-side pressure for the native token.

### Security and Risk Factors

Despite its robust design, the platform is not without risks.

#### Infrastructure Risk
The **decentralized Guardian network** for the HyperUnit bridge presents a potential point of failure. In April 2025, the system experienced a service disruption when a Guardian went offline.

#### Market Manipulation
The platform has been targeted by sophisticated traders. Notable incidents include:
- **JELLY token manipulation**: Resulted in a **$13.5M loss** for the HLP after the token's price was manipulated by 400%
- **XPL flash squeeze**: Led to **$46M in profits** for the exploiting traders

#### Microstructure Risks
An **on-chain CLOB** exposes transactions before inclusion; during high volatility, order racing and toxic flow can increase slippage and liquidation risk for leveraged traders.


## Key Takeaways
- Hyperliquid operates a purpose-built L1 (HyperCore) embedding the CLOB in consensus for speed.
- HyperBFT (HotStuff-inspired) targets fast finality; HyperEVM ensures EVM compatibility with HYPE gas.
- HLP is a native vault acting as the unified counterparty and liquidator, socializing PnL to depositors.
- Perps (“Hyperps”) use funding from an 8h mark-price MA, avoiding external spot oracles.
- HIP-1/2/3 progressively enable permissionless tokens, AMM liquidity, and market deployments.
- HyperUnit Bridge supports native BTC/ETH/SOL via a 2-of-3 MPC TSS Guardian network.
- Risks: bridge guardian outages, market manipulation incidents (e.g., JELLY, XPL), and on-chain CLOB latency games.
- Tokenomics: ~93% of fees buy HYPE, linking trading volume to buy pressure.
