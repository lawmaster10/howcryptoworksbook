# Chapter VIII: MEV

Control over transaction ordering creates and redistributes value on-chain. This chapter connects market microstructure to MEV: who extracts it, how it impacts users, and what mitigations (private order flow, batch auctions, proposer-builder separation) can return value or reduce harm.

## Section I: The Market Chaos: Understanding MEV Fundamentals

Picture a busy marketplace with a peculiar setup. A big whiteboard where everyone must post their intended purchases before they can buy anything. A trader writes "buying 10 tomatoes from Stall A," and suddenly chaos erupts.

A fast-moving reseller spots the order, sprints to Stall A, buys the tomatoes first, then offers them back to the trader at a markup. Another reseller notices the trader is about to make a large purchase that will drive up tomato prices, so they buy just before the trader and sell immediately after, pocketing the price difference the trade created. Meanwhile, the market manager starts auctioning off the right to decide who gets served first: whoever pays the highest tip jumps to the front of the line.

This market chaos isn't just an analogy but exactly what happens in **the public mempool**, creating what researchers call a "dark forest" where revealing profitable trades attracts predators.

**Maximal Extractable Value (MEV)** is the profit that emerges from this system. Originally called "Miner Extractable Value" during Ethereum's proof-of-work era, MEV represents revenue extracted beyond standard block rewards and transaction fees by strategically ordering, including, or excluding transactions within blocks.

In our market analogy, the key players have clear roles: **searchers** are the fast-moving resellers scanning for opportunities, **builders** are market managers who construct blocks and bid their value to **proposers** (validators), and **proposers** are the market owners who choose which manager's arrangement to accept. This relationship has been formalized through auction systems that create a liquid market for block space by essentially letting market managers bid for the right to organize transactions.

The fundamental insight is that MEV arises from controlling transaction visibility and ordering. Some activities, like ensuring prices stay aligned or liquidating bad debt, can stabilize the market. However, the overall effect imposes an implicit tax on regular users through worse execution, while only well-funded professionals with the fastest infrastructure consistently win.

This creates the core tension: how transaction ordering, designed to be neutral infrastructure, becomes a sophisticated value extraction mechanism that threatens the very decentralization it's meant to serve.

## Section II: How Value Gets Extracted

### MEV Extraction Strategies

The strategies that emerge from this environment follow a predictable escalation. The simplest is **arbitrage**: buying an asset at a lower price on one exchange to sell it at a higher price on another. This actually helps the market by keeping prices aligned across different venues, but when competition heats up, searchers get more aggressive.

They start **front-running**, copying a trader's transaction but paying extra to go first. For example, when a trader spots an arbitrage opportunity where they can buy ETH for $3,000 on one DEX and immediately sell it for $3,050 on another DEX, a bot sees the transaction and submits the exact same arbitrage trade with higher gas fees to capture that $50 profit before the trader can.

Then comes the **sandwich attack**: they buy before a trader (driving up the price), let the trader buy at the inflated rate, then immediately sell at the higher price the trader created, capturing a near-riskless profit when their bundle lands as planned. For example, a trader tries to swap 10 ETH for a token at $100 per token, but a bot buys first pushing the price to $105, the trade executes at $105, then the bot immediately sells their tokens back at $104, pocketing the $4-5 spread they created by sandwiching the transaction.

Uniswap's deterministic pricing curve and public mempool visibility create predictable price impact. Searchers exploit this through a simple three-step process: front-run the incoming buy to push prices up, allow the target trade to execute at the worse price, then back-run sell to capture the spread. This works because AMMs must move price with each swap (that's how they discover fair value without order books), transaction intent is visible and reorderable in the mempool, and off-chain markets provide price anchors for profitable extraction.

Consider a representative sandwich attack on a medium-sized trade. A trader submits a transaction to swap 50 ETH for USDC on Uniswap, expecting to receive approximately $150,000 based on the current pool price of $3,000 per ETH. A searcher's bot detects this pending transaction in the mempool and immediately constructs a three-transaction bundle:

1. **Front-run**: The bot buys $100,000 worth of USDC using ETH, pushing the pool price from $3,000 to $3,020 per ETH.

2. **Victim's trade executes**: The trader's 50 ETH swap now executes at the inflated price, receiving only $148,500 in USDC instead of the expected $150,000 resulting in a $1,500 loss.

3. **Back-run**: The bot immediately sells its USDC position back to the pool. The pool price settles around $3,010 per ETH. The bot exits with a profit of approximately $1,200 after accounting for gas fees and slippage.

The trader paid $1,500 in invisible tax for revealing their intent publicly. The bot risked minimal capital (the trade bundle either executes atomically or reverts entirely) while extracting pure profit. This single transaction illustrates the MEV extraction dynamic in miniature: sophisticated actors use privileged information about pending transactions to extract value from regular users through strategic positioning and timing.

Searchers have developed increasingly sophisticated variations of this basic strategy. One example is **JIT (Just-In-Time) liquidity** on Uniswap v3, where searchers add concentrated capital around the exact trade price for just one block, capturing the trading fees before immediately withdrawing their liquidity.

**Liquidations** represent another category: when someone's borrowed too much against their collateral, searchers race to claim the reward for closing out the position. Unlike sandwiching, liquidations serve a necessary function, but the race to claim them still inflates costs for everyone.

### Benevolent vs. Malignant MEV

The market impact creates a fundamental tension between efficiency and fairness. While arbitrage enhances price discovery and liquidations maintain protocol health, the overall MEV ecosystem extracts an "invisible tax" from users. 

To understand this tension, it's useful to think of MEV on a spectrum from benevolent to malignant, judged by whether the extraction provides system-wide benefits or purely redistributes value from users to extractors.

**Benevolent MEV** serves necessary economic functions. CEX-DEX arbitrage enforces price consistency across markets, preventing exploitable price divergences that would otherwise destabilize trading. Liquidations preserve the solvency of lending protocols by ensuring under-collateralized positions get closed before they become bad debt that would burden all protocol users. These activities extract value, but they also deliver clear benefits: tighter price spreads and healthier lending markets.

**Malignant MEV** extracts value without providing commensurate benefits. Sandwich attacks are the clearest example: a bot detects a pending trade, artificially inflates the price by frontrunning it, lets the victim buy at the inflated rate, then immediately dumps to pocket the difference. The victim pays more, the searcher profits, and the market gains nothing. This is pure wealth transfer enabled by privileged information and ordering control.

Between these extremes sit context-dependent behaviors that blur the line. JIT (Just-In-Time) liquidity on Uniswap v3 demonstrates this ambiguity: searchers deposit concentrated liquidity milliseconds before a large trade, capture the fees, then immediately withdraw. On one hand, this provides liquidity exactly when needed and can reduce slippage for the trader. On the other hand, it crowds out passive liquidity providers who can't compete with millisecond-level precision, potentially degrading liquidity depth over time. The extraction helps one user while harming the broader ecosystem's capital efficiency.

Similarly, back-running oracle updates can stabilize prices by immediately arbitraging stale rates after fresh data arrives, but this speed advantage means searchers capture value that might otherwise accrue to regular arbitrageurs or traders. The system benefits from rapid price corrections, yet the concentration of profits among sophisticated actors with the fastest infrastructure raises fairness concerns.

The key distinction isn't whether value gets extracted (it always does), but whether that extraction serves a necessary function or merely exploits information and ordering advantages. Benevolent MEV creates positive externalities; malignant MEV is purely extractive; and context-dependent MEV delivers mixed outcomes that depend on market structure, competition, and time horizons.

Priority-gas-auction bidding historically spiked gas costs as bots competed for transaction priority; today much of that competition is off-chain via specialized auction systems where searchers bid for transaction ordering rights, reducing broad mempool fee spikes but often shifting costs into worse execution for users or rebates captured by intermediaries. This isn't just theoretical harm. Every sandwich attack represents value directly transferred from a user to a sophisticated actor, even if the fee externalities now appear less in the public mempool and more in private routing markets.

### Easy money?

There is a common misconception among newcomers trying to "be the searcher": front-running and sandwiching are not free money. Winning priority requires paying tips/fees and accepting price impact; mis-set slippage turns many attempts negative-EV. Loose slippage tolerances effectively give adversaries permission to move the price against the transactor (the order fills at a worse rate and overpays), while tight tolerances make transactions revert after base costs or builder tips are still paid. On AMMs, the bonding curve means each marginal unit gets pricier, so naive bots often donate value to sophisticated searchers, builders, and validators when they mis-price priority or slippage. In short, without precise simulation and risk controls, attempts to frontrun or sandwich frequently overpay for execution and become self-taxing rather than extracting value.

### How Users Can Protect Themselves

When users submit transactions to public mempools, they should expect them to be exploited. The good news is that there are several ways to protect against this:

**Set Tight Slippage Tolerances:** This is the first line of defense. Slippage tolerance controls how much worse of a price a user is willing to accept for their trade. Users should set it as low as possible while still allowing their trade to go through. Many people start with 0.5-1%, but this isn't foolproof. Tokens with low liquidity or high volatility can still be exploited even with these settings. If traders set it too tight (below 0.3%), their transactions might fail during normal market swings. Keep in mind that on public mempools, users still pay gas fees even when transactions fail. However, private RPCs can help avoid these costs.

**Use Private Orderflow Services:** Services like Flashbots Protect send transactions through private channels instead of broadcasting them publicly. This hides transactions from bots until they're already included in a block, protecting against front-running and sandwich attacks. Bonus: if a transaction fails, users don't pay gas fees, and they might even get some MEV savings refunded. The downside is that users need to trust these services to route transactions properly, so they should check the settings and which block builders the services work with.

**Trade Through Batch Auction Systems:** Protocols like CoW Swap and UniswapX work differently. Instead of submitting a specific transaction, users tell them what result they want. CoW Swap groups multiple orders together and executes them at once, which prevents sandwich attacks (these attacks rely on transactions being processed alone in a sequence). It also tries to match orders directly between users when possible, often getting a better price. UniswapX takes a different approach with Dutch-auction style execution where multiple parties compete to fill orders, protecting users through competition rather than batching.

**Split Large Trades:** For big trades, users should consider TWAP (Time-Weighted Average Price) orders. These break trades into smaller pieces spread across multiple blocks. This reduces how much each individual trade affects the price, making sandwich attacks less profitable. When possible, traders should combine this with private RPCs or intent-based systems to avoid attackers spotting patterns. Many DEX aggregators have TWAP features built in.

**Choose MEV-Aware Venues:** Some platforms build MEV protection directly into their design. Users should look for venues with frequent batch auctions like CoW Protocol and Gnosis Auction. New technologies like encrypted mempools (from Shutter Network and SUAVE/ePBS research) hide transaction details until they execute, though these aren't widely available yet. Uniswap v4 allows individual pools to add their own MEV protections like dynamic fees, but this varies by pool.

The goal isn't to completely eliminate MEV (that's impossible) but to make it harder and less profitable for attackers to target specific users. Even with all these protections, users should stay alert. The battle between MEV extractors and defenders constantly evolves, and new attack methods keep appearing. Remember that while these protections help against sandwich attacks, they don't stop all MEV types like liquidations. One more benefit of private routing: users don't waste gas fees on transactions that would have failed anyway.

## Section III: Flashbots: Taming the Dark Forest

By 2020, Ethereum faced exactly this market chaos at scale. The priority gas auctions described earlier were creating network congestion, while miners were capturing MEV through opaque, off-chain deals that favored sophisticated actors.

Enter **Flashbots**, a research organization founded in 2020 with a radical proposition: instead of trying to eliminate MEV, create transparent infrastructure to make it more fair and efficient. Their insight was that MEV extraction was inevitable, but the current system was wasteful and harmful to regular users.

MEV-Geth and the First Solution: In January 2021, Flashbots released **MEV-Geth** (a modified Ethereum client) with **mev-relay**, creating a private communication channel between searchers and miners. Instead of competing in the public mempool with escalating gas bids, searchers could submit transaction bundles directly to miners through this sealed-bid auction system. This moved the competition off-chain, reducing PGA spam in the public mempool while professional searchers could still compete for MEV opportunities.

The Transition to Proof-of-Stake: When Ethereum moved to proof-of-stake in September 2022, the entire MEV landscape needed rebuilding. Flashbots developed **MEV-Boost**, an open-source middleware that provides **out-of-protocol Proposer-Builder Separation (PBS)**. This expanded the builder-validator relationship introduced earlier into a full competitive marketplace via **relays**. As of mid-2025, approximately 90% of Ethereum blocks are built via MEV-Boost. Note that this is distinct from **enshrined PBS**, which remains in development and research phases.

This process is facilitated by trusted entities called relays. Relays act as a neutral escrow and auctioneer: builders send them full blocks, and the relay verifies their validity and bid. The relay then forwards only the block header and the bid to the proposer. The proposer chooses a header without seeing the block's contents, preventing them from stealing the MEV opportunity. This reliance on a small number of trusted relays, however, introduces its own centralization and censorship concerns, as the choice of which relays to trust can determine which transactions are included in blocks. Because only a handful of relays dominate the market, their compliance decisions—such as filtering transactions to adhere to OFAC sanctions—can have network-wide effects, turning these supposedly neutral intermediaries into powerful chokepoints that shape which transactions actually make it into blocks regardless of individual validator preferences.

The system evolved from individual miners making direct deals to a sophisticated auction where multiple builders compete for validator selection, with relays facilitating the bidding process.

User Protection Through Flashbots Protect: Recognizing that infrastructure alone wasn't enough, Flashbots launched Flashbots Protect, a service that routes user transactions through private mempools. This shields regular users from the MEV extraction strategies detailed earlier while potentially providing rebates from captured MEV. The service works by bypassing the public mempool and reducing sandwich/frontrunning risk. These transactions still compete in the builder auction but are not exposed to public mempool predation.

The Flashbots approach represents a pragmatic philosophy: since MEV extraction is inevitable in any system with transaction ordering, the goal should be making it transparent, efficient, and less harmful to users. Rather than fighting the economic forces, they built infrastructure to channel them constructively. However, this infrastructure-based solution revealed an uncomfortable truth: organizing MEV markets efficiently also created powerful chokepoints that concentrated control in unexpected ways.

## Section IV: The Centralization Crisis

Despite Flashbots' innovations, the MEV ecosystem faces a fundamental challenge: success requires both substantial capital and technical expertise. Participants need resources to compete in liquidation auctions, sophisticated infrastructure to detect opportunities microseconds faster than competitors, and deep technical knowledge to navigate an increasingly complex landscape. The inevitable result is concentration of power.

The data from 2024 reveals the extent of this concentration. In October, just two builders produced 90% of blocks over a two-week period. From October 2023 through March 2024, three builders controlled approximately 80% of MEV-Boost blocks. During this same timeframe, a significant share of blocks, often around 60%, were relayed via OFAC-compliant infrastructure. The pattern is unmistakable: a handful of well-capitalized operators dominate MEV extraction, directly undermining blockchain's decentralized principles.

This centralization problem has driven new solutions. In November 2024, major players launched **BuilderNet**, a decentralized block-building network jointly operated by Flashbots, Beaverbuild, and Nethermind. BuilderNet uses **Trusted Execution Environments (TEEs)** to enable a novel approach: multiple operators can share transaction order flow and coordinate block building while keeping contents private until finalization.

The goal is to create a more transparent and permissionless system for MEV distribution, replacing the opaque, custom deals that currently define the market. Beaverbuild has already begun transitioning its centralized builder to this network, with additional permissionless features planned for future releases.

The broader toolkit approach recognizes that different participants need different strategies. The ecosystem has developed several categories of solutions:

Returning Value to Users: **Order flow auctions (OFAs)** let users auction off their transaction flow to the highest bidder, potentially earning rebates from the MEV their trades create. Private orderflow solutions route transactions through protected channels, examples include MEV-Share (which shares MEV profits with users), private relays that bypass the public mempool, and encrypted mempools that hide transaction details until execution.

Protocol-Level Protections: Researchers are exploring **MEV-smoothing** (distributing MEV rewards more evenly across validators) and enshrined PBS (Proposer-Builder Separation built directly into the protocol rather than relying on external infrastructure like MEV-Boost).

Addressing Advanced Attacks: **Time-bandit attacks**, where validators reorganize recent blocks to capture MEV, are constrained by stronger finality guarantees under proof-of-stake, though related attack vectors remain an active research concern.

While these solutions show promise, results in practice remain mixed, and the arms race between MEV extraction and protection continues to evolve.

## Section V: Cross-Domain MEV

Just as the industry began addressing single-chain MEV, a new challenge emerged that threatens to dwarf the current problems. **Cross-Domain MEV** represents extraction strategies that span multiple blockchains simultaneously, exploiting price differences and timing advantages across separate domains.

This isn't theoretical. Advanced searchers are already executing arbitrage and other strategies across different L1s, exploiting price differences between DEXs on separate chains. The timing and latency of blockchain bridges become critical factors, enabling complex, multi-block MEV strategies that are even harder to mitigate than their single-chain counterparts.

Researchers warn it could pose severe risks (sometimes described as 'existential') to decentralization. If specialized participants gain control over transaction ordering across multiple domains, the centralization pressures we've seen on individual chains could compound exponentially. The cross-domain nature makes coordination harder and value extraction more opaque, potentially creating a new class of MEV that's both more profitable and more harmful to users.

The challenge is that as the ecosystem grows and interconnects, each new bridge, each new chain, each new connection creates fresh opportunities for value extraction. The solutions that work for single-chain MEV (batch auctions, private orderflow, fair ordering) become exponentially more complex when they must coordinate across multiple domains with different consensus mechanisms, block times, and economic models.

## Section VI: Key Takeaways

**Rather than a bug to be fixed, MEV is a fundamental property of blockchains.** The public mempool functions as a "dark forest" where revealing profitable intent attracts predators; sandwich attacks alone extract billions annually from regular users who simply want to trade. Users should assume their transactions are vulnerable by default and actively seek protection through private orderflow, tight slippage bounds, or batch auction mechanisms.

**Whether extraction serves the ecosystem or merely taxes it depends on the distinction between benevolent and malignant MEV.** Arbitrage that enforces cross-exchange price consistency and liquidations that preserve protocol solvency provide system-wide benefits. These activities extract value but deliver public goods in return. Sandwich attacks, conversely, are pure wealth transfer: a bot artificially inflates prices, forces victims to trade at worse rates, then immediately dumps for profit while providing zero benefit to markets or users. The same technical capability (transaction reordering) produces radically different outcomes depending on whether it creates positive externalities or simply exploits information asymmetry.

**By choosing pragmatism over idealism, Flashbots built infrastructure to organize MEV markets rather than eliminate them.** MEV-Boost now facilitates roughly 90% of Ethereum blocks through a competitive builder auction. This moved extraction from chaotic priority gas auctions that congested the network into structured off-chain markets. The approach acknowledges an uncomfortable truth: fighting inevitable economic forces wastes resources; channeling them through transparent systems at least reduces harm to users and network stability. However, this infrastructure-first solution revealed that organizing markets efficiently also creates powerful chokepoints, with a handful of builders now controlling the vast majority of block production—highlighting the deep-seated centralizing pressure inherent to MEV extraction.

**Despite MEV extraction's technical sophistication, centralization undermines the entire value proposition of blockchain.** When three builders control 80% of blocks and capital requirements for competitive searcher operations run into millions of dollars, the system devolves into exactly what blockchains were designed to prevent: concentrated power among a small elite. TEE-based solutions like BuilderNet attempt to distribute block construction while preserving privacy, but the fundamental tension remains. Sophisticated MEV extraction demands resources and expertise that naturally concentrate in the hands of well-capitalized professionals. This creates an implicit tax where regular users pay worse execution prices to fund a system that benefits primarily those who can afford millisecond-level infrastructure advantages.

**Active defense is essential for user protection because the default assumption should be that your transactions will be exploited.** Private orderflow through services like Flashbots Protect, intent-based systems like CoW Swap that use batch auctions to eliminate timing games, and tight slippage tolerances all reduce but don't eliminate MEV exposure. The misconception that "being the searcher" offers easy profits ignores that winning priority requires paying tips, accepting price impact, and maintaining sophisticated simulation infrastructure. Naive attempts typically donate value to more sophisticated actors rather than extracting it. The arms race between protection and extraction continues to evolve, meaning vigilance and understanding of current attack vectors remains essential for anyone transacting significant value on-chain.

**As the next frontier, cross-domain MEV represents a challenge where current mitigations break down entirely.** As bridges connect chains and arbitrageurs execute multi-block strategies across separate domains, the complexity of coordinating fair execution across different consensus mechanisms, block times, and economic models compounds exponentially, threatening to create extraction opportunities that dwarf single-chain MEV while being even more opaque and harder to defend against. The infrastructure that somewhat contained MEV on individual chains faces an architectural mismatch when value flows across domains, potentially enabling a new class of sophisticated attacks that further concentrate power among the few participants capable of coordinating cross-chain strategies at scale.