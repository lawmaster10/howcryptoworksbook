# Chapter VIII: Stablecoins and RWAs

The promise of cryptocurrency was always bigger than speculation—it was about rebuilding financial infrastructure from first principles. Nowhere is this transformation more visible than in the evolution of stablecoins and tokenized real-world assets. What began as experimental attempts to create "digital dollars" has matured into institutional-grade infrastructure handling trillions in annual volume and attracting traditional finance giants like BlackRock.

### Types of Stablecoins

Stablecoins maintain their value through five distinct mechanisms, each offering different trade-offs between security, yield generation, and decentralization. The most established approach involves f**iat-backed stablecoins** (such as USDT by Tether), which maintain their peg by holding equivalent reserves of cash or cash equivalents such as treasuries and short-term government bonds. It's worth noting that these stablecoins typically do not pass the interest they earn down to holders and instead keep it as revenue.

A second category, **crypto-backed stablecoins** like USDS from Sky, uses other cryptocurrencies as collateral. These systems typically require overcollateralization, where the reserve value exceeds the stablecoin's value to account for the inherent volatility of crypto assets. This approach trades capital efficiency for the benefit of remaining within the cryptocurrency ecosystem.

More sophisticated **synthetic stablecoins** have emerged, exemplified by USDe from Ethena. These maintain stability through delta-hedging Bitcoin, Ethereum, and other assets using perpetual contracts. By executing automated and programmatic delta-neutral hedges against their underlying backing assets, they create stability while potentially generating yield from funding rates.

The newest type comes in the form of **U.S. Treasury-backed stablecoins**, sometimes called "yieldcoins." Examples like USDY from Ondo maintain their peg by holding equivalent reserves of short-term U.S. Treasuries, but unlike traditional fiat-backed variants, they pass the earned interest down to holders. This effectively creates tokenized money market funds that combine blockchain accessibility with traditional fixed-income returns.

Finally, **algorithmic stablecoins** represent perhaps the most ambitious but ultimately failed experiment in the space. These systems attempted to maintain stability through programmed mechanisms that automatically adjust token supply based on market demand, without requiring any collateral backing. While worth mentioning from a historical perspective, all major algorithmic stablecoins have failed, with the UST (Luna) collapse serving as the most prominent cautionary tale.

## Section I: Fiat Stablecoins

The dominant stablecoin model emerged from brutal market selection. Fiat-backed stablecoins like USDT and USDC, which currently have about a quarter of a trillion dollars in circulation, survived multiple crypto winters by embracing a simple truth: stability requires real backing, not just code.

These stablecoins maintain their $1 peg through an elegant arbitrage mechanism. When the price drifts below parity, arbitrageurs purchase the discounted stablecoins and redeem them for dollars. Conversely, when the price rises above $1, they deposit dollars, receive stablecoins in exchange, and sell them at a premium. This constant rebalancing keeps prices stable, but only if the underlying reserves and redemption mechanisms remain credible.

It's important to note that while fiat-backed stablecoins are issued on permissionless blockchains, the assets themselves operate under traditional financial regulations. They can be frozen if illegal activity is suspected, and Know Your Customer (KYC) protocols are required for both redemptions and new issuances. This hybrid model—combining blockchain efficiency with regulatory compliance—has proven to be the winning formula for achieving both scale and institutional adoption.

### USDT

**USDT** is a stablecoin issued by Tether and the most widely adopted stablecoin globally, with $170 billion in circulation. Since its 2014 launch, Tether faced early challenges around transparency and banking relationships, but the company has since achieved full compliance and now publishes quarterly attestations through BDO Italia.

Tether generates most of its revenue from yield earned on U.S. Treasury bills, reverse repos, and money market funds. This business model proved highly profitable in 2024, delivering $13 billion in net profit. The company has been reinvesting these profits into long-term growth areas including AI, renewable energy, and communications infrastructure. Tether also maintains approximately $10 billion each in Bitcoin and gold reserves on its balance sheet.

### USDC

**USDC** is a stablecoin issued by Circle, a publicly traded company on the NYSE (CRCL). As the second most widely used stablecoin, USDC has $75 billion in circulation and Circle has established a strong reputation for transparency and regulatory compliance in the U.S.

Circle maintains its reserves primarily in the BlackRock-managed Circle Reserve Fund, a government money market fund, along with cash holdings. The company has demonstrated its commitment to transparency by publishing monthly assurance reports conducted by Deloitte since 2022.

Unlike Tether, Circle reported relatively modest profits of $156 million in 2024. This is partly explained by the revenue-sharing arrangement between Circle and Coinbase for USDC interest income: each platform retains 100% of the interest generated by USDC held on its own platform, while they split the interest from off-platform USDC holdings equally.

### PYUSD

**PayPal USD (PYUSD)** is a stablecoin issued in collaboration between PayPal and Paxos. PYUSD can be used on PayPal or Venmo, and it is issued on Ethereum, Solana, and Arbitrum. There are no fees for transactions within PayPal. PYUSD is much smaller than USDT and USDC and currently has $1.4 billion in circulation.

### EUR Stablecoins

EUR stablecoins remain negligible compared to their USD counterparts, representing less than 1% of the total stablecoin market. The two largest EUR stablecoins are EURC (Circle) with approximately $220 million in circulation and EURS (Stasis) with around $120 million. 

This disparity stems from several interconnected factors. The U.S. dollar's global dominance in international trade and finance naturally extends to to crypto, where USD-denominated assets have broader acceptance and deeper integration across CEXs, DEXs and other DeFi protocols. 

Compounding this structural advantage, the European Union's regulatory landscape has created additional headwinds for euro-denominated stablecoins. MiCA imposes stringent compliance requirements that generate both uncertainty and operational barriers, deterring issuers from launching EUR stablecoins and users from adopting them.

### De-pegging risks

Despite their robust stabilization mechanisms, fiat-backed stablecoins still face **de-pegging risk**—the failure to maintain 1:1 parity with the underlying asset. This risk is fundamentally tied to **reserve-confidence shocks**, where questions about the quality, accessibility, or management of the issuer's backing assets can trigger a crisis of confidence. When users lose faith in a stablecoin's backing, they rush to sell their holdings for BTC, ETH, or fiat currencies, creating intense selling pressure that pushes the token's market price below $1 until redemptions and arbitrage activities restore parity.

The **March 2023 U.S. banking crisis** provided a clear example of this dynamic. After Circle disclosed that approximately $3.3 billion of **USDC's** cash reserves was held at the failing Silicon Valley Bank, the stablecoin fell as low as **$0.87 on March 11, 2023**. This episode demonstrated how interconnected stablecoins are with the traditional financial system and how external banking issues can directly impact stablecoin stability. The price recovered after the joint Treasury/Fed/FDIC statement on **March 12, 2023** backstopped deposits and Circle resumed redemptions on March 13.

**USDT** experienced its most severe de-pegging crisis in **October 2018** with intraday lows as low as **$0.86** amid a perfect storm of banking and confidence issues. The crisis was precipitated by reports that **Noble Bank**—a key banking partner that had serviced Tether and Bitfinex in Puerto Rico—was seeking a buyer and had lost clients, with both Tether and Bitfinex reportedly looking elsewhere for banking support.

These episodes illustrate how banking infrastructure problems can create feedback loops where concerns about redemption capacity fuel panic selling—effectively creating digital bank runs that only resolve once normal banking relationships and redemption processes are restored. The interconnected nature of stablecoin reserves with traditional banking systems means that external financial sector stress can directly threaten the stability mechanisms these tokens rely upon.

### Regulations
#### United States

In the U.S., stablecoins are now governed by The GENIUS Act, which was signed into law in July 2025 and establishes a comprehensive regulatory framework for USD stablecoins. Only "permitted issuers" may issue stablecoins to U.S. people, specifically subsidiaries of insured banks, federally qualified issuers supervised by the OCC, or state-qualified issuers (capped at $10 billion outstanding). Issuers must maintain strict 1:1 reserves in approved assets (USD cash, bank deposits, short-term Treasuries, and similar instruments), publish monthly reserve reports with independent accounting examinations, and comply with tailored Bank Secrecy Act/AML obligations including customer identification and OFAC sanctions compliance.

The law requires issuers to maintain technical capabilities to block or freeze tokens pursuant to lawful orders, prohibits paying interest on the stablecoins themselves, and bars marketing that implies U.S. government backing. Foreign-issued stablecoins are generally prohibited unless Treasury deems the home country's regulatory regime comparable and the issuer meets additional U.S. requirements. The framework becomes effective by January 18, 2027 (or 120 days after final regulations), with a three-year phase-out period after which U.S. digital asset service providers cannot offer non-compliant payment stablecoins. Importantly, compliant stablecoins are not classified as securities or commodities, and stablecoin holders receive priority claims on reserves in issuer insolvency proceedings.

In September 2025, Tether announced the launch of USAT, a new U.S.-regulated stablecoin designed to comply with GENIUS Act. USAT will leverage Anchorage Digital as the federally regulated issuer and Cantor Fitzgerald as the reserve custodian.

#### European Union

Under the EU's **Markets in Crypto-Assets (MiCA)** regulation, single-currency stablecoins are classified as **e-money tokens (EMT)** and subject to stringent reserve requirements designed to ensure liquidity and systemic stability. Standard EMT issuers must hold at least **30% of their reserves as deposits with EU-authorized credit institutions**, with the remainder in high-quality liquid assets. However, "significant" tokens—those with higher systemic risk and potential monetary policy impact—face elevated requirements, including a **60% deposit floor** and enhanced supervision by the European Banking Authority. This tiered approach reflects regulators' concern about redemption runs and contagion effects from larger stablecoin operations.

The framework also incorporates operational safeguards and concentration limits to prevent over-reliance on single institutions. Issuers must distribute deposits across multiple EU banks (often requiring six or more banking partners for significant EMTs), maintain formal liquidity management policies, conduct regular stress testing, and keep reserves segregated with detailed reporting to supervisors. Notably, while **euro-denominated EMTs face no usage restrictions**, non-EUR stablecoins are subject to **means-of-exchange caps**—if their daily transaction volume exceeds 1 million transactions or €200 million in any EU currency area, issuers must halt new issuance until compliance is restored. This regulatory architecture effectively anchors stablecoin liquidity to the EU banking system while maintaining supervisory control and limiting systemic exposure.

Circle achieved full MiCA compliance in July 2024 through a French Electronic Money Institution license, allowing both USDC and EURC to operate in the EU's. Circle chose to comply to bring stablecoins into mainstream acceptance by providing regulatory certainty. Despite complying, Circle has also critiqued certain MiCA reserve requirements—particularly high bank deposit mandates—as introducing unnecessary bank risk, showing Circle supports the framework's clarity and market access while advocating for refinements to specific prudential details.

Tether chose not to comply with MiCA and exchanges had to delist or restrict USDT in the EU. The company said that it wouldn't comply primarily because the requirements for stablecoins to hold at least 60% of reserves in EU bank deposits creates "systemic risk" and makes both stablecoins and banks less safe than holding short-term U.S. Treasuries. Tether believes that bank deposits are inherently more fragile since banks re-lend them (citing the SVB/USDC incident as evidence), while Treasuries offer superior safety and liquidity as reserve assets. Additionally, Tether views MiCA's bank concentration limits and operational requirements as adding unnecessary complexity and risk, while the broader EU restrictions on non-euro stablecoin usage are seen as hostile to dollar-denominated stablecoins' everyday use in Europe.

#### Use Cases

Stablecoins have become **core crypto plumbing**, accounting for more than 50% of global crypto transaction value in 2023–2024. Visa estimates approximately $5.7 trillion in stablecoin settlement volume for 2024, after adjusting for wash trading and bot activity. This massive scale demonstrates that stablecoins have evolved far beyond their origins as trading instruments to become genuine payment and transfer infrastructure. They have proven especially valuable in regions where traditional financial systems are inadequate, restricted, or unreliable.

**Trading and arbitrage remain the dominant applications**, with arbitrage activity highly concentrated among a small set of professional firms. Market makers maintain capital reserves in USDT and USDC, positioning themselves to quickly capitalize on price differences across centralized exchanges, decentralized exchanges, and different geographic regions.

Beyond trading, cross-border payments and remittances represent one of stablecoins' most transformative applications. The cost advantages are substantial: sending a $200 remittance from Sub-Saharan Africa costs approximately 60% less using stablecoins compared to traditional fiat-based methods. This dramatic cost reduction makes stablecoins attractive to migrant workers and underbanked populations. Strong adoption has followed in Latin America and Sub-Saharan Africa, where stablecoins provide both a hedge against local currency volatility and practical access to USD-denominated value. Geographic adoption data shows these regions experiencing over 40% year-over-year growth in retail and professional-sized stablecoin transfers.

Stablecoins also serve as a critical store of value in regions facing economic instability or high inflation. They allow individuals and businesses to preserve purchasing power when local currencies become unreliable. This use case has proven especially significant in countries experiencing monetary instability, where stablecoins often trade at premiums reflecting users' willingness to pay for stability and faster money movement. Turkey leads the world in stablecoin trading volume as a percentage of GDP. Meanwhile, countries across the Middle East and North Africa are seeing stablecoins capture larger market shares than traditionally dominant cryptocurrencies like Bitcoin and Ethereum.

The institutional adoption of stablecoins has reached new heights. Traditional financial institutions increasingly integrate them into operations for liquidity management, settlement mechanisms, and as entry points into cryptocurrency markets. Major payment processors including Stripe, Mastercard, and Visa have launched products enabling users to spend stablecoins through traditional payment rails. This trading infrastructure has enabled cross-border investment applications through tokenized assets. Investors now swap into stablecoins to access tokenized U.S. Treasury funds like Franklin's BENJI, **BlackRock's BUIDL**, and Ondo's OUSG, enabling 24/7 settlement capabilities.

While trading and arbitrage continue to dominate global stablecoin flows, the infrastructure is expanding into broader economic applications. The significant growth in retail usage across high-inflation economies, combined with emerging institutional applications through tokenized assets, signals an important shift. **Stablecoins are transitioning from primarily serving sophisticated financial players toward becoming genuine alternatives to traditional banking systems**—especially in regions where conventional financial infrastructure fails to meet local needs. This evolution suggests stablecoins may play an increasingly central role in global financial infrastructure as adoption patterns mature.

---

## Section II: Real World Assets

While stablecoins proved that blockchains could handle money, **Real World Asset (RWA) tokenization** represents the next step. This process moves traditional financial assets on blockchain, which helps provide greater efficiency, transparency, and global accessibility than conventional financial rails.

The shift is already underway. BlackRock's BUIDL fund surpassed $2 billion in assets under management (AUM) in April 2025, marking a significant development for tokenized Treasury exposure. Franklin Templeton launched the first U.S.-registered mutual fund to record transactions and share ownership on a public blockchain. Meanwhile, JPMorgan's Kinexys platform processes daily volumes exceeding $2 billion. The platform powers intraday repurchase agreements and tokenized settlement processes. What began as crypto-native experiments has now attracted the world's largest asset managers.

**RWA tokenization** spans the full spectrum of traditional finance. The range extends from U.S. Treasury bills to complex private credit arrangements. Real estate, stocks, and commodities bridge the gap between these extremes.

The tokenization process requires four critical components that work together to create a functional system. The **legal structure** forms the foundation through legal wrappers—typically Special Purpose Vehicles (SPVs) or trusts—that hold the underlying assets while protecting them from bankruptcy risks. **On-chain management** utilizes smart contracts to manage ownership records and handle distributions automatically, replacing traditional back-office processes. **Data bridges** play a crucial role as oracles serve as secure bridges that bring real-world asset prices and performance data into blockchain systems. Finally, **regulatory compliance infrastructure** enforces regulatory requirements while preserving the programmable nature of blockchain transactions.

RWAs are typically designed to remain isolated from bankruptcy risks. Additionally, U.S. registered products regulated under '40 Act must maintain a dedicated transfer agent. This agent keeps official shareholder records and processes all distributions and redemptions according to regulatory standards.

As of September 2025, approximately $30 billion worth of RWAs have been issued on-chain, with participation from more than 200 different issuers. The market breakdown shows about $17 billion concentrated in Private Credit, $7 billion in U.S. Treasury Debt, and another $2 billion in commodities. The majority of these RWAs are issued on Ethereum.

### Treasury and Fixed Income

**Tokenized Treasuries** became RWA's first major success story because they solve a clear problem: DeFi protocols needed high-quality, yield-bearing collateral that wasn't subject to crypto volatility. U.S. Treasury bills offer the perfect combination of safety, liquidity, and yield, but traditional finance made them difficult to access programmatically.

**BlackRock's BUIDL fund** represents a watershed moment: the world's largest asset manager offering a tokenized money market fund that accrues income daily and pays distributions in-kind as additional BUIDL tokens. **Franklin Templeton's FOBXX** went further, becoming the first U.S.-registered mutual fund to record transactions and share ownership on a public blockchain rather than just tokenizing claims.

The mechanics vary but follow similar patterns. Some protocols use daily NAV updates with redemption windows, while others employ continuous pricing through authorized market makers. **Ondo Finance** pioneered widely-used tokenized Treasuries (OUSG for qualified purchasers) and yield-bearing cash equivalents (USDY/rUSDY for broader access), bridging institutional and retail markets with 24/7 on-/off-ramping capabilities.

Other notable issuers/operators include **Superstate** (tokenized short-term government funds), **Backed** (tokenized ETFs and bonds), and **Hashnote**.

Because RWA tokens are programmable, they can be rehypothecated across DeFi—posted as collateral while still earning underlying yield. New institutional venues (e.g., **Aave Horizon**) allow qualified users to borrow against tokenized Treasuries/CLOs, improving capital efficiency versus off-chain workflows. 

Moving beyond Treasuries, **corporate bonds** and **private credit** represent the next frontier. Platforms like **Centrifuge** and **Maple Finance** facilitate on-chain lending to real-world borrowers, but must navigate complex credit assessment, legal documentation, and default resolution processes. The challenge isn't technical but rather operational, requiring traditional finance expertise alongside blockchain integration.

### Tokenized Stocks

Tokenized stocks and ETFs are emerging as regulated wrappers around traditional securities. These digital assets enable on-chain ownership records and round-the-clock settlement while operating within existing regulatory frameworks.

Several providers are leading this space with different approaches. **Superstate** enables publicly listed companies to tokenize their equity on Ethereum and Solana, with plans to let private companies go public directly on-chain. Meanwhile, operators like **Backed Finance** and **WisdomTree** issue on-chain shares representing claims on underlying ETFs. These typically include KYC/AML requirements, transfer restrictions, and jurisdictional limits.

Current market activity remains modest although it was reported that BlackRock is considering ways of tokenizing ETFs. The main use cases today focus on portfolio rebalancing, collateralization, and programmable settlement rather than retail trading.

### Real Estate Tokenization

**Real estate tokenization** promises to democratize property investment. Instead of needing hundreds of thousands to buy a rental property, investors could own $1,000 worth of a diversified portfolio and receive proportional rental income. Early platforms tokenize individual properties, with each token representing LLC shares in the underlying asset.

However, three critical hurdles limit real estate tokenization in practice. First, properties require regular appraisals to maintain accurate valuations, creating ongoing costs and potential disputes. Second, real estate is inherently illiquid since you can't instantly convert a building to cash when markets turn. Third, operational management remains complex: someone must handle property maintenance, tenant relations, and local regulatory compliance.

### Commodity Tokenization

**Commodity tokenization** attempts to solve similar problems for physical assets. **Pax Gold (PAXG)** represents actual gold bars stored in Brink's vaults, with each token backed by one troy ounce of London Good Delivery gold. **Tether Gold (XAUT)** offers similar exposure through different custody arrangements.

These products address the fundamental challenge of bridging physical and digital worlds: storage costs, insurance, audit verification, and redemption logistics. When you hold PAXG, you theoretically own real gold, but accessing that gold requires navigating complex custody and shipping arrangements.

### Regulatory Reality

RWA tokenization operates at the complex intersection of securities law and digital assets. Most RWA tokens qualify as securities under U.S. law, but rather than pursue expensive public registrations, protocols use regulatory workarounds that enable innovation while limiting mainstream adoption.

The most common approach is **Regulation D** private placements (limited to accredited investors) or **Regulation S** offshore offerings (excluding U.S. persons). This regulatory arbitrage creates both opportunities and constraints that shape how protocols operate in practice.

Most protocols attempt to utilize the **compliance as code** approach: embedding regulatory requirements directly into smart contracts rather than relying on manual oversight. Tokens can enforce **whitelisting** (only approved addresses can hold them), **transfer restrictions** (lock-up periods, accredited investor requirements), and **regulatory reporting** (automatic transaction monitoring and beneficial ownership tracking).

Platforms like **Securitize** provide compliance-focused infrastructure, handling KYC/AML verification, investor accreditation, and ongoing regulatory reporting. This infrastructure layer is critical but invisible to most users: the regulatory plumbing that makes tokenization legally viable.

Standardized token frameworks such as **ERC-1400** and **ERC-3643** encode transfer restrictions, partitions, and compliance checks at the token level. Increasingly, compliance portability is handled at the wallet level via whitelisting backed by verifiable credentials/attestations, enabling investors to reuse KYC/AML proofs across venues without fragmenting liquidity.

### Market Infrastructure

Tokenization promises improved liquidity for traditionally illiquid assets, but this promise hasn't materialized. The result is a paradox: tokens designed to make illiquid assets more tradeable often lack meaningful secondary markets themselves.

Traditional securities benefit from established exchanges, professional market makers, and deep institutional participation. Tokenized RWAs often trade on decentralized exchanges with minimal liquidity or private markets with restricted access. A tokenized real estate property might trade only a few times per month, if at all.

This liquidity challenge means that many RWA tokens function more like traditional private placements than the liquid, tradeable assets their proponents envision. **Secondary market liquidity** remains the Achilles' heel of RWA tokenization.

### Technical Implementation

The technical challenges of RWA tokenization stem from a fundamental mismatch: blockchains operate with precision and instant finality, while traditional finance relies on human processes, business days, and T+2 settlement cycles.

**Oracle integration** becomes critical when protocols need to bridge off-chain and on-chain worlds. Oracles are services that securely feed real-world data—like asset prices, NAV calculations, and performance metrics—into blockchain systems. But this creates new dependencies and potential failure points that protocols must carefully manage.

**Custody and settlement** present the most complex bridging challenges. **Qualified custodians** must hold underlying assets in traditional finance systems while smart contracts manage token issuance and transfers on-chain. This creates a coordination problem: blockchain transactions settle in minutes, but traditional securities settle in days. Protocols must carefully manage this timing mismatch to avoid creating unbacked tokens or settlement failures.