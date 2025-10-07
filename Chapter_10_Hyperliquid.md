# Chapter X: Hyperliquid

## Section I: Road to Domination

The decentralized perpetuals market evolved through distinct phases, each attempting to solve the speed-decentralization dilemma differently. **Synthetix** pioneered synthetic perps with pooled debt but suffered from oracle latency and lack of adoption. **dYdX** popularized order book perps but struggled with retaining market share against competitors.

### The Great Reversal: How Hyperliquid Dethroned dYdX

In one of the most dramatic competitive reversals in DeFi history, dYdX's share of perp DEX volume fell from 75% in January 2023 to 7% by December 2024, while newcomer **Hyperliquid** rose to nearly 70% in December 2024. This transformation occurred despite dYdX's seemingly unassailable position as the established leader with years of market dominance.

The roots of dYdX's failure can be traced to flawed strategic choices that made it susceptible to being overtaken. Most critically, the project's tokenomics offered limited value to users. The original v3 version, built on StarkEx, directed all trading fees to dYdX LLC with no direct benefit to token holders. Even after migrating to v4 as a Cosmos-based appchain, the protocol's fee structure remained problematic. Trading and gas fees flowed to validators and DYDX stakers in USDC, creating no buy pressure for the native token. When the buyback program finally launched in March 2025 (presumably as a response to Hyperliquid), it only captured 25% of fees and staked the repurchased tokens rather than burning them, creating a much weaker value accrual mechanism than traditional buyback-and-burn models.

Hyperliquid took the opposite approach, aligning incentives from day one. The platform conducted one of crypto's largest airdrops, distributing 31% of HYPE's total supply to over 90,000 users based on their trading activity on Hyperliquid's testnet and rival platforms like dYdX, with zero VC allocation, minimizing sell pressure. The airdrop's initial value exceeded $1B, with HYPE trading around $4 at launch in November 2024 before surging to nearly $60 by September 2025. More importantly, Hyperliquid's tokenomics implement direct value capture through aggressive buybacks, directing approximately 99% of trading fees toward HYPE purchases. This creates an unusually tight link between trading volume and token demand, essentially making HYPE a claim on future protocol cash flows, a mechanism more direct than that of typical governance tokens, which often struggle to capture value. Fee discounts stem primarily from volume and referral tiers rather than staking requirements alone.

While Hyperliquid refined its value proposition, dYdX was stumbling through a costly technical transition. The migration to v4 introduced user friction through complex bridging requirements and increased latency to ~1-second block times, precisely when speed became paramount. The timing proved disastrous, diverting critical resources to the overhaul just as Hyperliquid gained momentum.

This created an opening that Hyperliquid exploited with superior technology. Built as a custom L1 using proprietary HotStuff consensus, the platform achieved sub-second transaction finality with a median of 0.2 seconds. Most remarkably, it maintained a fully on-chain order book, something previously thought impossible without sacrificing speed. Unlike dYdX's hybrid approach, every bid, ask, and cancellation was recorded on-chain with transparent depth and zero gas fees for trading.

The market responded immediately and decisively. By August 2024, Hyperliquid's monthly volume first overtook dYdX. The gap then widened dramatically: by January 2025, Hyperliquid processed $200B while dYdX managed just $20B. In the second half of 2025, Hyperliquid is in a league of its own and frequently surpasses $300B in monthly volume, reaching about 15% of Binance's perp volume.

This reversal demonstrates that in crypto's fast-moving markets, superior user experience combined with aligned tokenomics can rapidly overcome established market positions, even when the incumbent enjoys years of advantage and institutional backing.

## Section II: HyperBFT and EVM

Hyperliquid built **HyperCore**, a bespoke L1 blockchain optimized for maximum speed and developer accessibility. The architecture involves two key decisions that create their own trade-offs.

### Consensus Layer: HyperBFT

**HyperBFT** powers the consensus layer, drawing inspiration from HotStuff to achieve fast finality under standard Byzantine assumptions (more than two-thirds honest validators). The system organizes block production through deterministic leader schedules, with epochs spanning roughly 100,000 rounds (approximately 90 minutes). This design prioritizes consistent, predictable performance over the variable block times common in other chains.

The speed gains come with centralization risks inherent to leader-based systems. If a designated leader misbehaves or goes offline, they can temporarily censor transactions until the next rotation. While validator rotation and monitoring mitigate this risk, it represents a meaningful trade-off compared to leaderless consensus mechanisms.

#### Validator Economics

To become an active validator, each participant must self-delegate at least 10,000 HYPE tokens. Active validators earn the right to produce blocks and receive rewards based on their total delegated stake.

Validators can charge delegators a commission on earned rewards. However, to protect delegators from exploitation, commission increases are strictly limited: validators can only raise their commission if the new rate remains at or below 1%. This prevents validators from attracting large amounts of stake with low commissions, then dramatically increasing fees to take advantage of unsuspecting delegators.

One-day delegation locks and seven-day unstaking periods balance validator commitment with capital liquidity, though these parameters create their own trade-offs between security and flexibility.

### Execution Layer: HyperEVM

**HyperEVM** addresses the accessibility challenge by providing full EVM compatibility, using HYPE as the native gas token. This allows existing Ethereum wallets, tools, and developer workflows to integrate seamlessly, a crucial factor for adoption.

#### Collateral System

USDC serves as collateral on Hyperliquid. All perpetual positions use USDC as collateral, creating a unified margin system that simplifies risk management and capital efficiency. The platform's dominance in attracting capital is evident in its nearly $6 billion in bridged USDC from Arbitrum.

In September 2025, Circle announced it would launch a native version of USDC on Hyperliquid, starting with the HyperEVM network and expanding to HyperCore later. Circle also invested in HYPE tokens, making it a direct stakeholder in the platform. This development comes shortly after Hyperliquid held a competition to select an issuer for its native USDH stablecoin, which was won by Native Markets.

### Tradable Products

Hyperliquid offers three main trading products: perps (standard perpetual futures), hyperps (pre-launch perps that use internal pricing instead of external oracles), and spot trading on fully on-chain order books. The platform also has upcoming features like permissionlessly deployed perps (HIP-3).

Listing mechanisms vary by product type. Spot listings require winning Dutch auctions to deploy HIP-1 tokens on HyperCore, then creating trading pairs through additional auctions. Perp listings are currently curated by the team with community input, though they're moving toward permissionless deployments via HIP-3. Hyperps remain curated and are specifically designed for assets without reliable external price feeds.

All spot assets trade as HIP-1 tokens on HyperCore's L1, regardless of their origin. This includes bridged assets like Bitcoin; when a participant deposits BTC or SOL, it becomes a HIP-1 representation that trades on the on-chain order book, then can be withdrawn back to the Bitcoin or Solana blockchain.

Non-EVM assets like Bitcoin and Solana use Unit's lock-and-mint bridge, while EVM-based assets like USDC from Arbitrum use Hyperliquid's native validator-signed bridge. For Bitcoin, users send native BTC to a deposit address monitored by Unit. Once confirmed on the Bitcoin blockchain, Unit mints the corresponding HIP-1 token representation on HyperCore that can be traded. Withdrawals work in reverse. The HIP-1 token is burned and Unit releases the native BTC back to the user's address. 

Hyperps are used primarily for trading perps of tokens before they are launched, either to speculate or hedge the price of farmed proceeds. Hyperp prices remain more stable and resist manipulation compared to standard pre-launch futures. The system also provides greater flexibility; the underlying asset or index only needs to exist when the contract settles or converts, not throughout the entire trading period.

Funding rates play a crucial role in hyperp trading. When prices move strongly in one direction, the funding mechanism will heavily incentivize positions in the opposite direction for the following eight hours. This creates both opportunities and risks that traders must account for.

In August 2025, four coordinated whales executed market manipulation on Hyperliquid's XPL hyperps, profiting approximately $47M while causing over $60M in trader losses and wiping out $130M in open interest. The attack exploited Hyperliquid's reliance on a thin, isolated spot price feed by using just $184k to artificially inflate XPL's spot price nearly eightfold, which caused the futures price to spike from $0.60 to $1.80 in minutes and triggered cascading liquidations of short positions. While technically not an exploit since it operated within the protocol's design, the attack exposed critical vulnerabilities in hyperps. This prompted Hyperliquid to implement emergency safeguards including 10x price caps. 

Full on-chain verifiability means positions and liquidation thresholds can sometimes be inferred from public state and trading behavior. While that visibility improves auditability and market integrity, it also makes clustered liquidations easier to target: adversaries can strategically push mark prices through known liquidity-light levels to trigger cascades, and impose outsized losses on passive participants (including HLP) during stress. Mitigations include tighter per-asset risk limits and position caps, anti-manipulation bands around liquidation prices, staggered or batched liquidation flows, and circuit breakers. 

## Section III: The HLP Design

Fast execution means little without deep liquidity. Traders need tight spreads, minimal slippage, and reliable liquidation mechanisms, requirements that have historically favored centralized exchanges with dedicated market makers. Hyperliquid's solution creates new trade-offs between liquidity provision and risk concentration.

**The Hyperliquidity Provider (HLP)** represents Hyperliquid's most innovative design choice: a community-owned vault that simultaneously provides market-making services and handles liquidations. Depositors contribute capital to HLP and share in its profit and loss, creating a decentralized market-making system that doesn't rely on external firms. HLP's profits come primarily from market-making spreads and liquidation fees, while losses stem from adverse selection when sophisticated traders exploit market inefficiencies and from holding losing positions as the counterparty to winning trades.

This design solves several problems at once. HLP provides consistent liquidity across all markets, handles liquidations efficiently (crucial for leveraged trading), and distributes market-making profits to the community rather than extracting them to external firms. The system internalizes much of the trading flow, reducing the need for external counterparties.

However, this concentration creates meaningful risks. During extreme volatility, HLP depositors bear the losses from adverse selection and liquidation cascades. While HLP isn't the sole counterparty on the CLOB (anyone can post liquidity), it provides core baseline liquidity across markets and performs liquidations, creating concentration risk that traditional market-making structures distribute across multiple firms.

The **JELLY** manipulation in March 2025 demonstrated how vault-based systems can suffer losses from coordinated attacks. Attackers opened large leveraged positions ($4.5M short, two $2.5M longs) on a low-liquidity token JELLY, then manipulated the liquidation process while simultaneously pumping the token's price 250% on Solana. This created a $12 million unrealized loss that threatened the protocol's solvency. Validators had to make an emergency intervention, overriding the oracle price to prevent collapse, while the team quickly implemented fixes including better position size limits, improved liquidation mechanisms, and enhanced governance controls. All traders were compensated, but the incident exposed significant vulnerabilities in the platform's risk management architecture.

## Section IV: The Governance Balance

As Hyperliquid matured, it faced a classic DeFi dilemma: how to balance permissionlessness while maintaining quality and managing risk. While initially relatively centralized, the protocol now relies on a governance system centered around voting on proposals.

**Hyperliquid Improvement Proposals (HIPs)** govern platform evolution, with each proposal addressing specific aspects of permissionless expansion:

HIP-1 established a native token standard with a 31-hour Dutch auction mechanism, allowing anyone to list spot tokens. This democratizes token launches while using a 31-hour Dutch auction to set deployment gas/ticker costs, which raises the bar for drive-by launches since the auction format naturally selects for tokens with genuine demand.

HIP-2 introduced automated "Hyperliquidity" for spot pairs against USDC, ensuring baseline liquidity for newly listed HIP-1 tokens. This solves the chicken-and-egg problem where tokens need liquidity to attract traders, but they need traders to justify liquidity provision.

HIP-3 (only live on testnet) aims to make perpetual markets permissionless, subject to a 1 million HYPE staked requirement by the deployer. Builders receive a share of fees in return. This creates strong incentives for responsible listings while generating meaningful cost for spam or low-quality markets.

The 1 million HYPE requirement effectively limits perpetual launches to serious participants while aligning their incentives with market success. However, builders face validator-driven delisting and potential stake slashing for malicious or unsafe operation, effective for quality control but can discourage experimentation.

This governance structure reflects a sophisticated understanding of platform dynamics: pure permissionlessness can lead to spam and poor user experience, while excessive gatekeeping stifles innovation. The stake-based approach creates market-driven quality control.

## Section V: Road to Decentralization

Building in DeFi is fundamentally about balancing performance and decentralization, a trade-off where simultaneous optimization is rarely possible. Generally, successful protocols start off more centralized to achieve the speed and reliability needed for adoption, then gradually decentralize over time as they mature and their infrastructure becomes more robust.

Hyperliquid faces persistent criticism around several centralization vectors that critics argue undermine its decentralized positioning. The most prominent concern centers on validator control, where the Hyper Foundation controls approximately 80% of staked HYPE through its own validators. The Foundation serves as the protocol's primary steward, responsible for core development, infrastructure maintenance, and ecosystem grants, while holding significant token reserves to fund long-term operations. This concentration could theoretically allow a single entity to halt or steer the chain, raising questions about the protocol's resistance to censorship or coordinated control.

The validator experience itself has drawn significant scrutiny. The protocol relies on closed-source node software, forcing validators to run what critics describe as a "single binary" with limited documentation. Validators have publicly complained that this arrangement creates a "blind signing" scenario where they cannot inspect the code they're running, leading to frequent jailing incidents and making it difficult to assess risks independently.

The validator selection process has also faced criticism for being opaque, with reports of low rewards relative to self-bonding requirements and the emergence of a testnet HYPE black market. These dynamics raise questions about equitable access to validator seats and whether the system privileges insiders over independent operators.

Infrastructure dependencies present additional centralization risks that have manifested in real-world disruptions. Hyperliquid's architecture relies heavily on centralized APIs for both validator operations and user access. Validators reportedly need to call Hyperliquid-operated APIs to recover from jailing, while users depend on these same API servers to submit transactions and access market data.

This dependency became acutely apparent during a July 2025 incident when API traffic spikes caused 37 minutes of trading disruption. The outage effectively froze user interactions despite the underlying blockchain continuing to produce blocks, highlighting how centralized infrastructure can create single points of failure even when the consensus layer remains operational.

The bridge architecture adds another layer of centralization concerns. Withdrawals depend on permissioned 4-validator sets on Arbitrum (commonly summarized as 3-of-4 for the hot set), concentrating withdrawal authority in a small group of designated actors rather than being secured by the broader L1 staking consensus. This arrangement creates potential risks around fund security and withdrawal censorship if those permissioned validators were to collude or become unavailable.

Critics point to the JELLY token incident as evidence of discretionary control, where validators overrode market outcomes by delisting the token and forcing settlement. While this may have protected users from a problematic asset, it demonstrated that the protocol retains significant interventionist capabilities that run counter to decentralized ideals.

Hyperliquid has acknowledged these concerns and indicated plans to open-source code and decentralize infrastructure over time. However, critics argue that the current centralized dependencies create meaningful risks around censorship, single points of failure, and discretionary control that users should understand when evaluating the protocol's trustworthiness and long-term viability.

## Section VI: Emerging Competitors

Hyperliquid's success validated the perpetual DEX market and triggered an explosive wave of competition. By late 2025, the sector reached nearly $630 billion in monthly trading volume across at least twenty competing protocols. While Hyperliquid maintains its dominance, its meteoric rise has attracted both capital and competitive scrutiny. Established projects have pivoted toward perps, and well-funded newcomers have launched with differentiated strategies designed to chip away at the leader's advantage.

Two protocols have emerged with particularly distinct approaches to challenging Hyperliquid's position.

**Lighter: Verifiable Security Architecture**

**Lighter** positions itself as the security-first alternative, built as a zk-rollup whose custom ZK circuits generate cryptographic proofs for order-matching and liquidations. The protocol launched its public mainnet in early October 2025 on an Ethereum L2, with user collateral remaining custodied on Ethereum itself, a design choice detailed in its whitepaper that prioritizes asset security over raw performance. Lighter claims to be the first exchange to offer verifiable matching and liquidations, a positioning backed by external security reviews including zkSecurity's circuit audit and recent Nethermind Security audits covering core contracts and bridge infrastructure.

The platform's fee structure reinforces its retail-friendly positioning: standard users trading through the front end pay zero maker and taker fees, while API access and high-frequency trading flow incur charges. Funding payments remain peer-to-peer between longs and shorts rather than platform fees. This approach targets institutional and risk-conscious traders who prioritize verifiable safety in a landscape where, as perpetual DEXs achieve CEX-like speeds and deeper liquidity, attack surfaces expand proportionally. In this context, cryptographic verification becomes a competitive differentiator rather than merely a baseline feature.

**Aster: The Binance-Connected Challenger**

**Aster** takes a markedly different approach, emerging from the merger of Astherus and APX Finance with backing from YZi Labs (CZ's venture firm) and CZ serving in an advisory capacity. Binance has clarified it holds no official role, though the connection to its founder and former executives provides significant credibility and network effects.

The platform combines aggressive fee structures, starting around 0.01% maker and 0.035% taker with VIP tiering and a 5% discount for paying fees in $ASTER tokens, with differentiated features designed to attract diverse trader segments. Hidden Orders conceal position sizes for privacy-conscious traders, while dual trading modes serve both novices (Simple mode with up to 1001× leverage) and professionals (Pro mode with advanced tools). The "Trade and Earn" model allows yield-bearing assets like USDF (Aster's own fully-collateralized stablecoin, with variable APY promoted around 17% during Season 2) and asBNB to serve directly as collateral. Beyond crypto perpetuals, Aster has expanded into leveraged stock perpetuals in Pro mode, broadening its addressable market.

Reported metrics suggest significant traction: approximately $500 billion in cumulative volume, fees of over $110 million, and 1.8 million user addresses. However, these figures warrant scrutiny. DefiLlama temporarily delisted Aster's perpetual volumes amid wash-trading concerns, and data quality debates remain ongoing. The platform operates with a hybrid architecture, off-chain matching engine paired with on-chain settlement, a trade-off that enables faster execution while maintaining non-custodial asset security, though it may limit appeal to DeFi purists seeking fully decentralized infrastructure.

Aster continues to run aggressive incentive campaigns, with its Genesis/Dawn points program (Stage 3 currently live) designed to bootstrap liquidity and user adoption as it competes for market share.

## Section VII: Key Takeaways

**Tokenomics determine competitive outcomes more than technical superiority alone.** dYdX collapsed from 75% market share to 7% despite years of dominance. This was largely because it never gave users a compelling reason to hold DYDX tokens. Hyperliquid understood this from day one, directing majority of trading fees toward HYPE buybacks and distributing 31% of supply via airdrop with zero VC allocation; this created direct value capture that transformed HYPE from a governance token into a claim on protocol cash flows. The lesson extends beyond perpetual DEXs: protocols that treat tokens as afterthoughts will lose to competitors who align incentives from launch, regardless of technical advantages.

**Building for speed first, decentralizing as the protocol matures.** Hyperliquid achieved sub-second finality and fully on-chain order books through HyperBFT, performance that helped it capture significant market share quickly. This required deliberate tradeoffs: the Hyper Foundation currently controls approximately 80% of staked HYPE, validators run closed-source binaries, and withdrawals rely on permissioned 4-validator sets. These aren't oversights but intentional design choices that prioritize rapid iteration and security hardening in the protocol's early stages. The July 2025 API outage that froze trading for 37 minutes highlighted areas for improvement. As Hyperliquid matures and proves its security model at scale, the team can progressively decentralize by expanding the validator set, opening source code, and distributing stake more broadly. This staged approach lets the foundation move fast, learn from real-world stress tests, and gradually relinquish control as the system demonstrates resilience.

**HLP bootstrapped liquidity while the protocol finds sustainable solutions.** HLP solved the cold-start problem by letting depositors collectively provide market-making and handle liquidations, enabling Hyperliquid to launch competitive markets quickly. This was an intentional design choice for the early stage, though it concentrates risk on retail users rather than professional firms with diversified books. The JELLY incident, which created $12M in unrealized losses and required emergency validator intervention, and the XPL attack that exploited transparent on-chain positions, revealed the limitations of this approach. These events are valuable stress tests that inform the protocol's evolution. As Hyperliquid matures and attracts more market makers, HLP's role will naturally shift from primary liquidity provider to a backstop for new or less liquid markets. The team can develop additional mechanisms like private market-making vaults, tiered risk structures, or hybrid models that distribute risk more effectively while maintaining the on-chain transparency that makes the protocol valuable.

**Permissionless expansion requires sophisticated economic barriers, not just technical ones.** Hyperliquid's HIP framework demonstrates how protocols can decentralize without sacrificing quality: HIP-1's 31-hour Dutch auctions naturally filter spam by making deployers compete for listings, HIP-2's automated Hyperliquidity solves the chicken-and-egg problem for new tokens, and HIP-3's 1 million HYPE staking requirement ensures perpetual deployers have skin in the game. This approach recognizes that pure permissionlessness leads to noise and poor user experience; economic stakes create market-driven curation where builders must justify capital allocation upfront and face validator-driven delisting for malicious behavior. The trade-off is real. High barriers discourage experimentation, but platforms that mistake openness for value creation will fragment liquidity across worthless markets.

**Competition in perpetual DEXs now bifurcates along security versus network effects.** The sector reached nearly a trillion dollars in monthly volume across twenty protocols by late 2025, with challengers attacking Hyperliquid's dominance from opposite angles. Lighter bets that institutional traders will pay for cryptographic verification, offering zk-rollup architecture with Ethereum-custodied collateral and zero frontend fees for retail, while Aster leverages CZ's network and aggressive incentives to target volume maximalists who prioritize execution speed and novel features over decentralization purity. Neither approach directly replicates Hyperliquid's balance; Lighter sacrifices performance for verifiable security, Aster sacrifices credibility for growth hacking. The winner will depend on whether users ultimately care more about not getting hacked or about feeling like they're using the next Binance.

The perpetual DEX race ultimately reveals that **builders must choose their centralizations carefully, because all performance gains require trust trade-offs somewhere.** Hyperliquid chose validator concentration and closed-source infrastructure; Lighter chose zk-rollup latency; Aster chose Binance adjacency and off-chain matching. None of these are pure decentralization. They're different bets on which trust assumptions users will accept in exchange for speed, security, or network effects. As the sector matures and volumes approach centralized exchange levels, the protocols that survive will be those whose chosen centralizations align with user priorities and regulatory realities, not those claiming to have solved the impossible trilemma.