# Chapter VIII: MEV

Control over transaction ordering creates and redistributes value on-chain. This chapter explores who extracts that value, how it impacts regular users, and what protections exist to return value or reduce harm.

## Section I: MEV Fundamentals

Picture a busy marketplace with a peculiar setup. A big whiteboard where everyone must post their intended purchases before they can buy anything. A trader writes "buying 10 tomatoes from Stall A," and suddenly chaos erupts.

A fast-moving reseller spots the order, sprints to Stall A, buys the tomatoes first, then offers them back to the trader at a markup. Another reseller notices the trader is about to make a large purchase that will drive up tomato prices, so they buy just before the trader and sell immediately after, pocketing the price difference the trade created. Meanwhile, the market manager starts auctioning off the right to decide who gets served first: whoever pays the highest tip jumps to the front of the line.

This market chaos mirrors exactly what happens in the mempool, the public waiting area where transactions sit before being added to the blockchain (introduced in Chapter I for Bitcoin and Chapter II for Ethereum). While both networks use mempools, MEV primarily manifests on Ethereum and other smart contract platforms where complex DeFi transactions create extraction opportunities. The environment resembles what researchers call a "dark forest," borrowing from Liu Cixin's science fiction novel to describe a place where any visible movement attracts predators. In the mempool, revealing a profitable trade is that visible movement.

**Maximal Extractable Value** (MEV) is the profit that emerges from this system. Originally called "Miner Extractable Value" during Ethereum's proof-of-work era, MEV represents revenue extracted beyond standard block rewards and transaction fees by strategically ordering, including, or excluding transactions within blocks.

In our market analogy, the key players have clear roles: **searchers** are the fast-moving resellers scanning for opportunities, **builders** are market managers who construct blocks and bid their value to proposers (validators), and **proposers** are the market owners who choose which manager's arrangement to accept. This relationship has been formalized through auction systems that create a liquid market for block space by essentially letting market managers bid for the right to organize transactions.

The fundamental insight is that MEV arises from controlling transaction visibility and ordering. Some activities, like ensuring prices stay aligned or liquidating bad debt, can stabilize the market. However, the overall effect imposes an implicit tax on regular users through worse execution, while only well-funded professionals with the fastest infrastructure consistently win.

This creates the core tension: how transaction ordering, designed to be neutral infrastructure, becomes a sophisticated value extraction mechanism that threatens the very decentralization it's meant to serve.

## Section II: How Value Gets Extracted

### Benevolent vs. Malignant MEV

Before examining specific extraction strategies, we need a framework for evaluating their market impact. Not all MEV harms markets equally, and distinguishing productive from predatory extraction matters for both protocol design and user protection.

Benevolent MEV serves necessary economic functions. Arbitrage keeps prices roughly aligned across exchanges. Liquidations close unhealthy loans before they leave lenders with bad debt. Both extract value, but they also deliver clear benefits: more consistent prices and healthier lending markets.

Malignant MEV extracts value without providing commensurate benefits. **Sandwich attacks** exemplify this: the victim pays more, the searcher profits, and the market gains nothing. This is pure wealth transfer enabled by privileged information and ordering control.

**Just-in-time liquidity** demonstrates this ambiguity. When searchers see a large trade pending, they quickly add liquidity to the relevant pool just for that block, capture the swap fees from executing the trade, and then remove their liquidity immediately after the swap in the same block. On one hand, this provides liquidity exactly when needed and can reduce slippage for the trader. On the other hand, it crowds out passive liquidity providers who can't compete with such precision, potentially degrading liquidity depth over time.

Similarly, oracle updates create another ambiguous MEV channel. When a price feed like Chainlink posts a new price on-chain, searchers try to **back-run** that update by placing their arbitrage trade in the very next transaction. They use the fresh quote to trade against AMMs or perpetual futures that are still priced off the old level, snapping prices back into line. The system benefits from faster price correction, but in practice the profits accrue almost entirely to specialized operators with the fastest infrastructure.

The key distinction isn't whether value gets extracted (it always does), but whether that extraction serves a necessary function or merely exploits information and ordering advantages. This framework helps us evaluate the strategies that follow.

### MEV Extraction Strategies

From this chaos emerged a hierarchy of exploitation strategies, each more sophisticated than the last. Arbitrage, as described above, sits at the benevolent end. But when competition heats up, searchers get more aggressive.

They start **front-running**, which means copying a trader's transaction but paying extra to go first. For example, when a trader spots an arbitrage opportunity where they can buy ETH for $3,000 on one DEX and immediately sell it for $3,050 on another, a bot sees the pending transaction and submits the exact same trade with a higher fee to jump ahead in line, capturing that $50 profit before the original trader can.

Understanding why these strategies work requires recalling how AMMs function (covered in Chapter VII). The deterministic pricing curves mean the price impact of any proposed swap can be calculated in advance. Combined with the public mempool where transactions sit before inclusion, searchers can see a pending trade, estimate exactly how far it will move the price, and position their own transactions around it. Predictable pricing, visible intent, and reorderable transactions create a perfect environment for extraction.

Consider a representative sandwich attack. A trader submits a transaction to swap ETH for USDC on Uniswap. A searcher's bot detects this pending transaction in the mempool and immediately constructs a three-transaction bundle. First, the bot front-runs by buying USDC using ETH, which pushes the pool price higher. Then the victim's trade executes at this inflated price, receiving significantly less USDC than expected based on the original pool state. Finally, the bot back-runs by immediately selling its USDC position back to the pool. As the price settles back down, the bot exits with a profit after accounting for fees and slippage.

The trader pays an invisible tax for revealing their intent publicly. The bot risks minimal capital (the trade bundle either executes atomically or reverts entirely) while extracting pure profit. This single transaction illustrates the MEV extraction dynamic in miniature: sophisticated actors use privileged information about pending transactions to extract value from regular users through strategic positioning and timing.

Beyond price manipulation, liquidations represent another MEV category. Lending protocols (such as Aave, discussed in Chapter VII) set collateral ratios that are safe at the time of borrowing, and positions only become liquidatable when market moves push collateral value down (or debt value up) enough that they fall below the liquidation threshold. When an oracle update reflects that new price, searchers race to be first to repay part of the debt, seize a slice of the collateral, and collect the liquidation bonus. In practice they often back-run oracle updates by placing their liquidation transactions immediately after the price feed update in the same block. Unlike sandwiching, this competition serves a necessary function by clearing under-collateralized positions and keeping the protocol solvent, but it still turns user stress events into MEV auctions and concentrates rewards in the fastest operators.

Priority-gas-auction bidding historically spiked gas costs as bots competed for transaction priority; today much of that competition is off-chain via specialized auction systems where searchers bid for transaction ordering rights, reducing broad mempool fee spikes but often shifting costs into worse execution for users or rebates captured by intermediaries. This harm is far from theoretical. Every sandwich attack represents value directly transferred from a user to a well-capitalized operator, even if the fee externalities now appear less in the public mempool and more in private routing markets.

### How Users Can Protect Themselves

Given the MEV extraction landscape described above, what practical steps can users take? When submitting transactions to public mempools, assume exploitation is likely.

The first line of defense is a slippage limit: the most you will accept the execution price worsening before the trade is rejected. A tighter limit leaves less room for a sandwich attack, but increases the chance of a failed trade when prices move. The right limit depends on the token's liquidity and the size of your order.

Private transaction routing offers stronger protection. Services like Flashbots Protect route transactions through private channels instead of broadcasting them to the public mempool. This shields your intent until inclusion, protecting against front-running and sandwich attacks. Failed transactions through these services typically do not cost fees, and some services rebate part of the MEV they help you avoid. The tradeoff is weaker propagation: your order depends on a smaller set of relays and builders rather than the full public network, so inclusion can be less predictable.

Batch auction systems provide protection through mechanism design rather than just hiding intent. CoW Swap groups orders into batches and uses competitive solvers to find the best execution paths (as introduced in Chapter VII's intent-based systems section), which prevents sandwich attacks that rely on sequential processing. UniswapX uses a declining-price auction where the output offered to the user falls from a favorable starting amount toward a minimum. Fillers compete to execute early, before another filler captures the order. Both approaches make extraction structurally harder.

For large trades, splitting orders across multiple blocks reduces per-trade price impact and makes sandwich attacks less profitable. Time-weighted average price strategies, covered in Chapter VI, break trades into smaller pieces executed over time. Combining this approach with private routing or batch auctions provides layered protection.

Some platforms build protection directly into their design. Encrypted-mempool systems like Shutter Network keep transaction contents hidden until ordering is fixed, making frontrunning much harder. Since its January 2025 launch, Uniswap v4 has supported dynamic fees through hooks, which can also implement pool-specific MEV protections.

The goal is not complete MEV elimination, which is impossible, but making extraction harder and less profitable. These protections help against sandwich attacks but cannot stop all MEV types. The battle constantly evolves as new attack methods emerge.

### A Warning About "Easy Money"

Observing the profitability of MEV extraction, some newcomers wonder whether they should become searchers themselves. A reality check: being a searcher is not free money. Winning priority requires paying fees and accepting price impact, and poorly calibrated attempts often lose money. Because AMM pricing makes each additional unit more expensive to buy, naive bots frequently donate value to professional searchers, builders, and validators when they misjudge fees or slippage. Without precise simulation and risk controls, frontrunning or sandwich attempts often overpay for execution and end up losing rather than extracting value.

## Section III: Flashbots: Taming the Dark Forest

These user-facing protections emerged partly because the industry recognized that individual defenses alone weren't enough. By 2020, Ethereum faced exactly this market chaos at scale. The priority gas auctions described earlier were creating network congestion, while miners were capturing MEV through opaque, off-chain deals that favored well-capitalized participants.

Enter Flashbots, a research organization founded in 2020 with a radical proposition: instead of trying to eliminate MEV, create transparent infrastructure to make it more fair and efficient. Their insight was that the current system was wasteful, and that channeling extraction through better infrastructure could reduce harm.

### MEV-Geth and the First Solution

In January 2021, Flashbots released MEV-Geth, a modified Ethereum client that let miners accept transaction bundles over a private Flashbots channel instead of only from the public mempool. Rather than spamming ever-higher gas bids in priority gas auctions, searchers could submit bundles directly to miners running MEV-Geth. Miners simulated and ranked these bundles and included the most profitable ones in their blocks. This moved most of the competition off-chain, cutting down on bidding wars in the public mempool while still letting professional searchers compete for MEV opportunities.

### The Transition to Proof-of-Stake

When Ethereum moved to proof-of-stake in September 2022 (a transition detailed in Chapter II), the entire MEV landscape needed rebuilding. Flashbots developed **MEV-Boost**, an open-source middleware that provides **Proposer-Builder Separation** (PBS), a design where specialized builders construct blocks and validators simply choose which block to propose, rather than validators doing both jobs themselves. This expanded the builder-validator relationship introduced earlier into a full competitive marketplace via relays. As of early 2026, approximately 90% of Ethereum blocks are built via MEV-Boost.

On Ethereum mainnet, this separation still operates outside the core protocol through MEV-Boost. Enshrined PBS, specified in EIP-7732, became part of the Glamsterdam upgrade on Sepolia on October 6, 2026. Mainnet activation had not yet been scheduled as of October 11, 2026.

### How MEV-Boost Works

This process is facilitated by trusted entities called **relays**. Relays act as a neutral escrow and auctioneer: builders send them full blocks, and the relay verifies their validity and bid. The relay then forwards only the block header and the bid to the proposer (validators are also called proposers in this context). The proposer chooses a header without seeing the block’s contents, preventing them from stealing the MEV opportunity. The system evolved from individual miners making direct deals to a sophisticated auction where multiple builders compete for validator selection, with relays facilitating the bidding process.

These trust assumptions are not just theoretical. In April 2023, a validator exploited a vulnerability in MEV-Boost and relay handling to “unbundle” private bundles, copy profitable MEV transactions, and siphon more than $20 million from other searchers in a single block. The episode triggered urgent client patches and became the basis for the first high-profile U.S. criminal case about MEV infrastructure: in 2024, federal prosecutors charged two MIT-educated brothers with wire fraud and money laundering for allegedly orchestrating the exploit, with the case still being litigated as of early 2026\. Whatever one thinks of the legal theory, it underscored that MEV relays and builders are no longer just technical plumbing but also legal and regulatory attack surfaces.

### Expanding User Protection

Recognizing that infrastructure alone was not enough, Flashbots also launched the user-facing protection service mentioned earlier: Flashbots Protect. By routing transactions through private channels that bypass the public mempool, ordinary users gain protection from sandwich and frontrunning attacks while potentially receiving rebates from captured MEV. These transactions still compete in the builder auction but are never exposed to public mempool predation.

The Flashbots approach represents a pragmatic philosophy: given that extraction is baked into how ordering markets function, the goal should be making it transparent, efficient, and less harmful. Rather than fighting the economic forces, they built infrastructure to channel them constructively. However, this infrastructure-based solution revealed an uncomfortable truth: organizing MEV markets efficiently also created powerful chokepoints that concentrated control in unexpected ways.

## Section IV: The Centralization Crisis

Despite Flashbots' innovations, the MEV ecosystem faces a fundamental challenge: concentration of power among a small number of operators.

The concentration remained clear in October 2026. In Relayscan's week ending October 10, Titan built roughly half of observed MEV-Boost blocks, Quasar about a fifth, and BuilderNet about a sixth. Together, three builders produced around 90% of the total, leaving substantial influence with a handful of operators.

The relay layer introduces additional centralization concerns. Because only a handful of trusted relays dominate the market, their compliance decisions (such as filtering transactions to adhere to OFAC sanctions) can have network-wide effects. These supposedly neutral intermediaries become powerful chokepoints that shape which transactions actually make it into blocks regardless of individual validator preferences. The choice of which relays to trust can determine transaction inclusion, making censorship resistance vulnerable to a small set of gatekeepers.

### Responses to Centralization

The concentration revealed by these metrics made clear that MEV-Boost alone couldn't solve the centralization problem. The relay layer remained a chokepoint, and builder concentration continued unabated. The industry needed more fundamental restructuring.

In November 2024, Flashbots, Beaverbuild, and Nethermind launched BuilderNet to distribute block building across multiple operators. Its original design used secure enclaves, hardware that isolates code even from the machine's owner. As of October 2026, builder nodes were temporarily running outside these enclaves during an architecture transition, while order routing and backrunning retained enclave protection. Privacy guarantees therefore depend on which part of the system handles the data.

The goal is to create a more transparent and permissionless system for MEV distribution, replacing the opaque, custom deals that currently define the market. Beaverbuild retired its centralized builder in May 2025 in favor of this network, with additional permissionless features planned for future releases.

Beyond BuilderNet, the ecosystem has developed several complementary approaches to combat centralization and return value to users.

One approach focuses on returning value directly to users. **Order flow auctions** let users auction off their transaction flow to the highest bidder, potentially earning rebates from the MEV their trades create. The private routing solutions discussed earlier represent one implementation, while encrypted mempools hide transaction details until execution.

At the protocol level, researchers are exploring ways to distribute MEV rewards more evenly across validators rather than letting them concentrate among the fastest operators. Enshrined PBS, now being tested on Sepolia, builds proposer-builder separation into Ethereum's protocol rather than relying on external infrastructure like MEV-Boost.

More advanced attacks also require attention. **Time-bandit attacks**, where validators attempt to reorganize recent blocks to capture MEV, are constrained by stronger finality guarantees under proof-of-stake, though related attack vectors remain an active research concern.

While these solutions show promise, results in practice remain mixed, and the arms race between MEV extraction and protection continues to evolve.

## Section V: MEV on L2s

Chapter II established that most major rollups rely on centralized sequencers and noted how this concentrates MEV power. This section examines what that concentration actually means in practice, names who the operators are today, and addresses what protections users have.

The MEV dynamics on rollups have an important two-sided quality that the Chapter II overview did not develop. Because users submit transactions directly to the sequencer rather than broadcasting to a public mempool, the sandwiching bots that prowl Ethereum's broadcast queue have less visibility into pending L2 trades. In that narrow sense, rollup users gain protection from a class of MEV that is endemic on L1. The tradeoff is concentrated control: the sequencer sees transactions before inclusion and applies the network's ordering rules. Some rollups now sell ordering advantages through auctions or priority fees, but competition for those advantages is different from decentralizing the sequencer itself.

The operators differ across networks. Offchain Labs runs Arbitrum's sequencer, Coinbase runs Base's, Matter Labs runs zkSync's, and StarkWare runs Starknet's. Using a shared software stack does not mean sharing an operator: OP Labs develops the OP Stack but does not run every chain built with it. These networks process substantial DeFi activity, putting real power in a small number of hands.

### The Sequencer's MEV Advantage

A centralized sequencer could extract MEV in ways that are structurally different from L1. On Ethereum mainnet, a builder who wants to sandwich a user's trade must win a competitive auction, pay a significant portion of the MEV to validators, and operate sophisticated simulation infrastructure. A rollup operator controls transaction inclusion and the implementation of ordering rules. Where those rules are not independently enforced, users still depend on the operator to refrain from inserting its own transactions or favoring particular counterparties.

Latency advantages can also be sold explicitly. Arbitrum's **Timeboost** auctions control of an express lane in 60-second rounds. Ordinary transactions face a 200-millisecond delay that express-lane submissions avoid, giving the auction winner an advantage in time-sensitive arbitrage. The winner buys a head start, not control of the sequencer.

Base uses a different model: arrival time and priority fees help determine transaction ordering within its Flashblocks. Transactions arriving after a Flashblock has been built cannot bid their way into that earlier block, so both speed and fees matter. These mechanisms make some ordering advantages explicit and priced, but they do not remove the sequencer operator's control over inclusion or all opportunities to abuse privileged information. The relevant questions are which ordering rules apply, how they are enforced, and what users can verify independently.

### Decentralization Roadmaps

Chapter II surveyed the decentralization roadmaps for major rollup sequencers. The proposal most directly relevant to MEV is **based sequencing** (sometimes called "based rollups"), where L1 validators, rather than a designated L2 sequencer, order L2 transactions. Because L1 validators are already a large, distributed, economically bonded set, based sequencing inherits Ethereum's existing decentralization without requiring each rollup to bootstrap its own. The tradeoff is latency: L2 blocks can only finalize as fast as L1 blocks (~12 seconds), which may be too slow for latency-sensitive DeFi, but as a trust model it is substantially stronger than relying on a single operator.

### Shared Sequencing Networks

Chapter II mentioned shared sequencing networks in brief. Two specific implementations deserve attention here for what they offer on the MEV front.

**Espresso Systems** provides a shared confirmation layer. Rollups can retain their own sequencers and transaction ordering while Espresso's proof-of-stake network confirms their commitments, preventing conflicting histories once confirmed. Execution and bridge security remain separate concerns. **Astria** pursued shared sequencing more directly through a layer multiple rollups could use, but shut down its sequencer network in December 2025.

Shared sequencing can arrange for related transactions to be included together across rollups. But inclusion does not guarantee that both succeed: one rollup may execute its transaction while the other rejects its own. True all-or-nothing cross-rollup trades still need coordination beyond a shared ordering layer.

### What Protections Users Have Today

The user protection toolkit from Section II applies with important limitations on L2. Private mempool routing (Flashbots Protect and similar services) is largely irrelevant on rollups where transactions go directly to the sequencer by design; there is no public mempool to hide from.

Batch auction systems like CoW Swap, however, work independently of who runs the sequencer, because they determine execution through an off-chain solver competition rather than on-chain ordering. This makes intent-based trading systems (discussed in Chapter VII) particularly valuable on L2 for users who prioritize execution quality over speed. Slippage controls also remain useful, though on L2 the sequencer itself is a potential adversary: tight tolerances limit how much you lose if the sequencer reorders, but they do not prevent it from observing your transaction and acting on that information. The choice of which L2 to transact on is itself a protection decision: ordering auctions, priority-fee rules, operator commitments, and decentralization timelines vary meaningfully across rollups.

Selling a place at the front of the queue does not decentralize the sequencer. Timeboost and priority fees create competition for ordering advantages, but the operator retains substantial control. Users still need to know who enforces the rules and how they can exit if that operator fails or abuses its position.

## Section VI: The Cross-Domain Challenge

But even as these solutions emerge for single-chain L1 MEV and the ecosystem works toward decentralized L2 sequencing, a far larger threat looms. Just as the industry began addressing extraction within individual blockchains, a new challenge emerged that threatens to dwarf the current problems.

**Cross-Domain MEV** represents extraction strategies that span multiple blockchains simultaneously, exploiting price differences and timing advantages across separate domains.

This is not theoretical. Advanced searchers are already executing arbitrage and other strategies across different blockchains, exploiting price differences between DEXs on separate networks. The timing and latency of blockchain bridges become critical factors, enabling complex, multi-block MEV strategies that are even harder to mitigate than their single-chain counterparts.

Researchers warn it could pose severe risks (sometimes described as 'existential') to decentralization. If specialized participants gain control over transaction ordering across multiple domains, the centralization pressures described earlier could compound exponentially. The cross-domain nature makes coordination harder and value extraction more opaque, potentially creating a new class of MEV that's both more profitable and more harmful to users.

The fundamental challenge: as the ecosystem grows and interconnects, each new bridge, each new chain, each new connection creates fresh opportunities for value extraction. The solutions that work for single-chain MEV (batch auctions, private orderflow, fair ordering) become exponentially more complex when they must coordinate across multiple domains with different consensus mechanisms, block times, and economic models.