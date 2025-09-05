# Chapter VII: MEV

Control over transaction ordering creates and redistributes value on‑chain. This chapter connects market microstructure to MEV: who extracts it, how it impacts users, and what mitigations (private order flow, batch auctions, PBS) can return value or reduce harm.

## Section I: The Market Chaos - Understanding MEV Fundamentals

Picture a bustling marketplace with a peculiar setup: there's a big whiteboard where everyone must post their intended purchases before they can buy anything. You write "buying 10 tomatoes from Stall A," and suddenly chaos erupts.

A fast-moving reseller spots your order, sprints to Stall A, buys the tomatoes first, then offers them back to you at a markup. Another reseller notices you're about to make a large purchase that will drive up tomato prices, so they buy just before you and sell immediately after, pocketing the price difference your trade created. Meanwhile, the market manager starts auctioning off the right to decide who gets served first—whoever pays the highest tip jumps to the front of the line.

This market chaos isn't just an analogy—it's exactly what happens in Ethereum's **mempool**, creating what researchers call a "dark forest" where revealing profitable trades attracts predators.

**Maximal Extractable Value (MEV)** is the profit that emerges from this system. Originally called "Miner Extractable Value" during Ethereum's proof-of-work era, MEV represents revenue extracted beyond standard block rewards and transaction fees by strategically ordering, including, or excluding transactions within blocks.

In our market analogy, the key players have clear roles: **searchers** are the fast-moving resellers scanning for opportunities, **builders** are market managers who organize the optimal serving order to capture maximum tips, and **proposers** (validators) are the market owners who choose which manager's arrangement to accept. This relationship has been formalized through systems like **MEV-Boost**, which creates a liquid market for block space—essentially letting market managers bid for the right to organize transactions.

The fundamental insight is that MEV arises from controlling transaction visibility and ordering. Some activities (like ensuring prices stay aligned across different stalls or liquidating bad debt) can stabilize the market, but the overall effect leaves regular shoppers paying more and waiting longer while only well-funded professionals with the fastest runners and private backroom deals consistently win.

This creates the core tension we'll explore: how transaction ordering, designed to be neutral infrastructure, becomes a sophisticated value extraction mechanism that threatens the very decentralization it's meant to serve.

## Section II: The Strategies - How Value Gets Extracted

The strategies that emerge from this environment follow a predictable escalation. The simplest is **arbitrage**—our resellers buying tomatoes cheap at one stall to sell them expensive at another. This actually helps the market by keeping prices aligned, but when competition heats up, searchers get more aggressive.

They start **front-running**, copying your order but paying the market manager extra to go first. Then comes the **sandwich attack**: they buy before you (driving up the price), let you buy at the inflated rate, then immediately sell at the higher price you created, capturing a near‑riskless profit when their bundle lands as planned.

**Liquidations** represent another category—when someone's borrowed too much against their collateral, searchers race to claim the reward for closing out the position. Unlike sandwiching, liquidations serve a necessary function, but the race to claim them still inflates costs for everyone.

The market impact creates a fundamental tension between efficiency and fairness. While arbitrage enhances price discovery and liquidations maintain protocol health, the overall MEV ecosystem extracts an **"invisible tax"** from users. Priority‑gas‑auction bidding historically spiked gas costs as bots competed for transaction priority; today much of that competition has shifted off‑chain into order‑flow and builder auctions—reducing broad mempool fee spikes but often shifting costs into worse execution for users or rebates captured by intermediaries. This isn't just theoretical harm. Every sandwich attack represents value directly transferred from a user to a sophisticated actor, even if the fee externalities now appear less in the public mempool and more in private routing markets.

The response has been innovation in execution methods. **Frequent batch auctions** and **intent-based settlement** (like CoW Swap and Uniswap X) remove the continuous-time priority that enables sandwiching. Instead of processing trades one-by-one in a race, these systems collect orders and execute them together, eliminating the timing games that create MEV opportunities.

## Section III: The Centralization Crisis - When Markets Concentrate Power

This dynamic creates a brutal reality: success in MEV requires both deep pockets and technical expertise. You need capital to compete in liquidation auctions, sophisticated infrastructure to detect opportunities faster than competitors, and the technical knowledge to navigate an increasingly complex landscape. The result? Dangerous centralization.

Recent data reveals the scope of this concentration. In late 2024, block building was highly concentrated—for example, two builders produced roughly 80–90% of blocks over multi‑week windows—with daily shares fluctuating materially. Over the same period, a sizable share of blocks were relayed via OFAC‑compliant infrastructure, varying by measurement window (often around ~30–50%). The pattern is clear: a small number of sophisticated actors dominate MEV extraction, undermining the decentralized ethos of blockchain networks.

This concentration sparked innovation. In 2024, major players announced **BuilderNet**, a decentralized block-building network developed by Flashbots, Beaverbuild, and Nethermind. BuilderNet uses **Trusted Execution Environments (TEEs)** to allow multiple operators to share transaction order flow and coordinate block building while keeping contents private until finalized. Think of it as allowing multiple market managers to collaborate on organizing the optimal serving order without revealing their strategies to competitors.

This architecture aims to create a more transparent and permissionless system for MEV distribution, moving away from the opaque, custom deals that define the current landscape. Beaverbuild is already transitioning its centralized builder to this new network, with more permissionless features planned for future releases.

The broader toolkit approach recognizes that different participants need different strategies. **Order flow auctions (OFAs)** and **private orderflow** solutions (like MEV-Share, SUAVE, private relays, and encrypted mempools) seek to return value to users through rebates, though results in practice remain mixed. **Time-bandit attacks** (reorganizing blocks to capture MEV) are constrained by fast finality, while researchers explore **MEV-smoothing** and **enshrined PBS** (Proposer-Builder Separation) to further distribute value extraction.

### MEV Mitigation Strategies by Role

The response has been a toolkit approach, with different participants using different strategies:

| Role | Primary tactics | Tools / examples | Key trade‑offs |
| --- | --- | --- | --- |
| Users | Hide orderflow; constrain execution | Private RPCs (MEV‑Share, CoWSwap RPC), RFQ/intent routers (CoW Swap, Uniswap X), tight slippage + fill‑or‑kill, batch auctions | Less immediate execution on long‑tail pairs; routing trust; failed txs if constraints too tight |
| dApps / Protocols | Remove continuous‑time priority; internalize or rebate MEV | Frequent batch auctions, RFQ flows, intents + solver competitions, on‑chain hooks with anti‑sandwich checks, OFAs with rebates | Added complexity; potential latency; relies on robust solver markets and simulation guards |
| Builders | Privacy + integrity; fairness goals | PBS compliance, privacy‑preserving builders (TEE/encrypted), fair ordering within bundles, no‑sandwich policies, BuilderNet participation | Throughput/latency overhead; trust in TEEs/attestations; competitive pressure vs permissive builders |
| Validators / Proposers | Safe inclusion + value sharing | Use reputable relays, inclusion lists/inclusion guarantees, OFA revenue‑sharing, MEV‑smoothing pools, enshrined PBS (research) | Relay trust; potential revenue variance; policy constraints vs profit maximization |

Status notes: Inclusion lists (FOCIL/COMIS), enshrined PBS, and MEV‑smoothing are active research/proposals or pool‑level constructs; they are not deployed as protocol features on Ethereum mainnet.

**Operational notes:** Prefer intent/batch‑auction settlement for retail orderflow to eliminate sandwich windows. Enforce simulation, slippage bounds, and pause hooks at the protocol level to reduce exploit surfaces.

## Section IV: The Next Frontier - Cross-Domain MEV

Just as the industry began addressing single-chain MEV, a new challenge emerged that threatens to dwarf the current problems. **Cross-Domain MEV** extends our market analogy: imagine if the resellers could now sprint between multiple adjacent markets, buying low in Market A and selling high in Market B faster than anyone else could react.

This isn't theoretical. Sophisticated actors are already executing arbitrage and other strategies across different blockchain networks, exploiting price differences between exchanges on separate chains. The timing and latency of blockchain bridges become critical factors, enabling complex, multi-block MEV strategies that are even harder to mitigate than their single-chain counterparts.

Researchers warn this could pose an **"existential risk"** to decentralization. If sophisticated actors gain control over transaction ordering across multiple domains, the centralization pressures we've seen on individual chains could compound exponentially. The cross-domain nature makes coordination harder and value extraction more opaque, potentially creating a new class of MEV that's both more profitable and more harmful to users.

The challenge is that as the blockchain ecosystem grows and interconnects, each new bridge, each new chain, each new connection creates fresh opportunities for value extraction. The solutions that work for single-chain MEV—batch auctions, private orderflow, fair ordering—become exponentially more complex when they must coordinate across multiple domains with different consensus mechanisms, block times, and economic models.

Mitigations under study include **shared sequencing** across domains, **cross-domain batch auctions**, and **routing intents through OFAs** that can coordinate across chains. However, these solutions are still largely theoretical, and the race between MEV extraction and mitigation continues to intensify.

## The Ongoing Battle for Fair Markets

The MEV challenge illustrates a broader truth about decentralized systems: technical solutions create new economic realities, which create new technical challenges. What began as a simple ordering problem has evolved into a sophisticated ecosystem that threatens the very decentralization it was meant to preserve.

Yet the response has been equally sophisticated. From private orderflow to batch auctions, from BuilderNet to cross-domain coordination, the ecosystem continues to innovate. The market analogy that opened this chapter remains apt: just as physical markets developed regulations, clearing houses, and fair trading practices over centuries, blockchain markets are rapidly evolving their own mechanisms for fair value distribution.

The stakes couldn't be higher. MEV extraction that benefits sophisticated actors at the expense of regular users undermines the promise of decentralized finance. But the solutions emerging—intent-based systems, private execution, fair ordering mechanisms—point toward a future where the benefits of programmable money can be realized without the extractive dynamics that plague traditional finance.

As blockchain networks multiply and interconnect, the next chapter of this story is already being written across domains and chains. The question isn't whether MEV will continue to evolve, but whether the mitigations can keep pace with the extraction.