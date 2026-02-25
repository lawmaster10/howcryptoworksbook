# Chapter IX: Stablecoins and RWAs

The promise of cryptocurrency was always bigger than speculation, it was about rebuilding financial infrastructure from first principles. Nowhere is this transformation more visible than in the evolution of stablecoins and tokenized real-world assets. What began as experimental attempts to create "digital dollars" has matured into institutional-grade infrastructure handling trillions in annual volume and attracting Wall Street giants like BlackRock.

## Section I: Types of Stablecoins

Stablecoins maintain their value through four distinct mechanisms, each offering different trade-offs between security, yield generation, and decentralization. The most established approach involves **fiat-backed stablecoins** (such as USDT and USDC), which maintain their **peg** by holding cash or cash equivalents such as treasuries and short-term government bonds in 1:1 proportion to circulating supply. Traditional fiat-backed stablecoins like USDT and USDC do not pass the interest they earn down to holders and instead keep it as revenue.

A second category, crypto-backed stablecoins like USDS from Sky (examined in detail in Chapter VII), uses other cryptocurrencies as collateral. These systems typically require **overcollateralization** where crypto holdings exceed the stablecoin's value to account for inherent asset volatility. This approach trades capital efficiency for the benefit of remaining within the cryptocurrency ecosystem.

More sophisticated synthetic stablecoins have emerged, exemplified by USDe from Ethena (discussed in Chapter VII's yield generation section). These maintain stability through automated hedging strategies using perpetual futures (detailed in Chapter VI) to offset the price movements of their underlying crypto assets. By holding crypto collateral while simultaneously taking short positions that profit when prices fall, these stablecoins neutralize volatility. They can also generate yield from funding rates, the periodic payments that flow between traders holding long and short positions in derivatives markets.

A new type of stablecoins, sometimes called "yieldcoins" (such as USDY from Ondo), uses the same backing mechanism as fiat-backed stablecoins but passes earned interest to holders, effectively creating tokenized money market funds that combine blockchain accessibility with traditional fixed-income returns. The distinction here is business model, not the mechanism for maintaining the peg.

Finally, **algorithmic stablecoins** represent perhaps the most ambitious but ultimately failed experiment in the space. These systems attempted to maintain stability through programmed mechanisms that automatically adjust token supply based on market demand, with no asset reserves. The fatal flaw emerged during confidence shocks: when users rushed to exit, the algorithms minted more of the backing token to maintain the peg, but this dilution crashed the backing token's value, further undermining confidence in the stablecoin and creating a reflexive death spiral where the stabilization mechanism itself accelerated collapse. While worth mentioning from a historical perspective, all major algorithmic stablecoins have failed, with the UST (Luna) collapse serving as the most prominent cautionary tale.

The remainder of this chapter focuses primarily on fiat-backed stablecoins, which dominate the market with over 95% of total stablecoin circulation and have proven most viable for institutional adoption.

## Section II: Fiat Stablecoins

The dominant stablecoin model emerged from brutal market selection. USDT and USDC, which currently have about a quarter of a trillion dollars in circulation, survived multiple crypto winters by embracing a simple truth: stability requires tangible assets, not algorithmic promises.

These stablecoins maintain their peg through **arbitrage** mechanisms that create profit opportunities whenever price deviates from $1. When a stablecoin trades below $1, arbitrageurs buy the discounted tokens and redeem them from the issuer for exactly $1 worth of backing assets, pocketing the difference. Conversely, when price rises above $1, authorized participants can mint new tokens by depositing $1 of collateral with the issuer, then sell these tokens at a premium. This continuous arbitrage activity pulls the price back toward parity, but only if the underlying reserves and redemption mechanisms remain credible. Combined with strong reserve management, this mechanism has proven to be the winning formula for achieving both scale and institutional adoption.

### USDT

USDT is a stablecoin issued by Tether and the most widely adopted stablecoin globally, with $187 billion in circulation as of early 2026\. Since its 2014 launch, Tether faced early challenges around transparency and banking relationships, but the company has since achieved much better compliance and publishes quarterly attestations, which are third-party verifications of its reserves conducted by accounting firm BDO Italia.

Tether generates most of its revenue from yield earned on U.S. Treasury bills, reverse repos, and money market funds. This business model proved highly profitable in 2024, delivering $13 billion in net profit. The company has been reinvesting these profits into long-term growth areas including AI, renewable energy, and communications infrastructure. Tether also maintains approximately $10 billion each in Bitcoin and gold reserves on its balance sheet.

### USDC

USDC is a stablecoin issued by Circle, a publicly traded company on the NYSE (CRCL). As the second most widely used stablecoin, USDC has $75 billion in circulation and Circle has established a strong reputation for transparency and regulatory compliance in the U.S.

Circle maintains its reserves primarily in the BlackRock-managed Circle Reserve Fund, a government money market fund, along with cash holdings. The company has demonstrated its commitment to transparency by publishing monthly assurance reports conducted by Deloitte since 2022\.

Unlike Tether, Circle reported relatively modest profits of $156 million in 2024\. This is partly explained by the revenue-sharing arrangement between Circle and Coinbase for USDC interest income: each platform retains 100% of the interest generated by USDC held on its own platform, while they split the interest from off-platform USDC holdings equally.

### PYUSD

PayPal USD (PYUSD) is a stablecoin issued in collaboration between PayPal and Paxos. PYUSD can be used on PayPal or Venmo, and it is issued on Ethereum, Solana, and Arbitrum. There are no fees for transactions within PayPal. PYUSD is much smaller than USDT and USDC and currently has $1.4 billion in circulation.

### EUR Stablecoins

EUR stablecoins remain negligible compared to their USD counterparts, representing less than 1% of the total stablecoin market. The two largest EUR stablecoins are EURC (Circle) with approximately $220 million in circulation and EURS (Stasis) with around $120 million. This disparity stems from the U.S. dollar's global dominance in international trade and finance, which naturally extends to crypto where USD-denominated assets have broader acceptance across centralized exchanges, decentralized exchanges, and DeFi protocols. The EU's MiCA regulation, discussed below, has compounded this structural advantage by creating additional compliance barriers that deter both issuers and users.

### Regulations

While fiat-backed stablecoins are issued on permissionless blockchains, the assets themselves operate under existing financial regulations. They can be frozen if illegal activity is suspected, and Know Your Customer (KYC) protocols are required for both redemptions and new issuances. This hybrid model, combining blockchain efficiency with regulatory compliance, has enabled stablecoins to achieve both scale and institutional adoption while remaining subject to evolving regulatory frameworks across different jurisdictions.

#### United States

In the U.S., stablecoins are now governed by The GENIUS Act, which was signed into law in July 2025 and establishes a comprehensive regulatory framework for USD stablecoins. Only "permitted issuers" may issue stablecoins to U.S. people, specifically subsidiaries of insured banks, federally qualified issuers supervised by the Office of the Comptroller of the Currency, or state-qualified issuers (capped at $10 billion outstanding). Issuers must maintain strict 1:1 reserves in approved assets (USD cash, bank deposits, short-term Treasuries, and similar instruments), publish monthly reserve reports with independent accounting examinations, and comply with tailored Bank Secrecy Act and anti-money laundering obligations including customer identification and sanctions compliance.

The law requires issuers to maintain technical capabilities to block or freeze tokens pursuant to lawful orders, prohibits paying interest on the stablecoins themselves, and bars marketing that implies U.S. government backing. Foreign-issued stablecoins are generally prohibited unless Treasury deems the home country's regulatory regime comparable and the issuer meets additional U.S. requirements. The framework becomes effective by January 18, 2027 (or 120 days after final regulations), with a three-year phase-out period after which U.S. digital asset service providers cannot offer non-compliant payment stablecoins. Importantly, compliant stablecoins are not classified as securities or commodities, and stablecoin holders receive priority claims on reserves in issuer insolvency proceedings.

In September 2025, Tether announced the launch of USAT, a new U.S.-regulated stablecoin designed to comply with GENIUS Act. USAT will leverage Anchorage Digital as the federally regulated issuer and Cantor Fitzgerald as the reserve custodian.

#### European Union

Under the EU Markets in Crypto-Assets (MiCA) regulation, single-currency stablecoins are classified as e-money tokens (EMT) and subject to stringent reserve requirements designed to ensure liquidity and systemic stability. Standard EMT issuers must hold at least 30% of their reserves as deposits with EU-authorized credit institutions, with the remainder in high-quality liquid assets. However, "significant" tokens, those with higher systemic risk and potential monetary policy impact, face elevated requirements, including a 60% deposit floor and enhanced supervision by the European Banking Authority. This tiered approach reflects regulators' concern about redemption runs and contagion effects from larger stablecoin operations.

The framework also incorporates operational safeguards and concentration limits to prevent over-reliance on single institutions. Issuers must distribute deposits across multiple EU banks (often requiring six or more banking partners for significant EMTs), maintain formal liquidity management policies, conduct regular stress testing, and keep reserves segregated with detailed reporting to supervisors. Notably, while euro-denominated EMTs face no usage restrictions, non-EUR stablecoins are subject to means-of-exchange caps, if their daily transaction volume exceeds 1 million transactions or €200 million in any EU currency area, issuers must halt new issuance until compliance is restored. This regulatory architecture effectively anchors stablecoin liquidity to the EU banking system while maintaining supervisory control and limiting systemic exposure.

Circle achieved full MiCA compliance in July 2024 through a French Electronic Money Institution license, allowing both USDC and EURC to operate in the EU. Circle chose to comply to gain mainstream acceptance and regulatory clarity. Despite complying, Circle has also critiqued certain MiCA reserve requirements, particularly high bank deposit mandates, as introducing unnecessary bank risk, showing Circle supports the framework's clarity and market access while advocating for refinements to specific prudential details.

Tether chose not to comply with MiCA and exchanges had to delist or restrict USDT in the EU. The company said that it wouldn't comply primarily because the requirements for stablecoins to hold at least 60% of reserves in EU bank deposits creates "systemic risk" and makes both stablecoins and banks less safe than holding short-term U.S. Treasuries. Tether believes that bank deposits are inherently more fragile since banks re-lend them (citing the SVB/USDC incident as evidence), while Treasuries offer superior safety and liquidity as reserve assets. Additionally, Tether views MiCA's bank concentration limits and operational requirements as adding unnecessary complexity and risk, while the broader EU restrictions on non-euro stablecoin usage are seen as hostile to dollar-denominated stablecoins' everyday use in Europe.

### De-pegging risks

Despite their robust stabilization mechanisms, fiat-backed stablecoins still face de-pegging risk, the failure to maintain 1:1 parity with the underlying asset. This risk is fundamentally tied to reserve-confidence shocks, where doubts about reserve quality or accessibility can trigger a crisis of confidence. When users lose faith in a stablecoin's backing, they rush to sell their holdings for BTC, ETH, or fiat currencies, creating intense selling pressure that pushes the token's market price below $1 until redemptions and arbitrage activities restore parity.

The March 2023 U.S. banking crisis (also discussed in Chapter VII's Curve section) provided a clear example of this dynamic. After Circle disclosed that approximately $3.3 billion of USDC's cash reserves was held at the failing Silicon Valley Bank, the stablecoin fell as low as $0.87 on March 11, 2023\. This episode demonstrated how interconnected stablecoins are with legacy banking infrastructure and how external banking issues can directly impact stablecoin stability. The price recovered after the joint Treasury/Fed/FDIC statement on March 12, 2023 backstopped deposits and Circle resumed redemptions on March 13\.

USDT experienced its most severe de-pegging crisis in October 2018 with intraday lows as low as $0.86 amid a perfect storm of banking and confidence issues. The crisis was precipitated by reports that Noble Bank, a key banking partner that had serviced Tether and Bitfinex in Puerto Rico, was seeking a buyer and had lost clients, with both Tether and Bitfinex reportedly looking elsewhere for banking support.

These episodes illustrate how banking infrastructure problems create feedback loops. Concerns about redemption capacity can fuel panic selling, effectively creating digital bank runs. These crises only resolve once normal banking relationships and redemption processes are restored. The interconnected nature of stablecoin reserves with incumbent banking systems means that external financial sector stress can directly threaten the stability mechanisms these tokens rely upon.

### Use Cases

Stablecoins have become core crypto plumbing, accounting for more than 50% of global crypto transaction value each year. Visa estimates approximately $5.7 trillion in stablecoin settlement volume in 2024, after adjusting for artificial volume from bots and fake trades designed to inflate activity metrics. This massive scale demonstrates that stablecoins have evolved far beyond their origins as trading instruments to become genuine payment and transfer infrastructure. They have proven especially valuable in regions where legacy financial systems are inadequate, restricted, or unreliable.

#### Trading and Arbitrage

Trading and arbitrage remain the dominant applications, with arbitrage activity highly concentrated among a small set of professional firms. Market makers maintain capital reserves in USDT and USDC, positioning themselves to quickly capitalize on price differences across centralized exchanges, decentralized exchanges, and different geographic regions.

#### Cross-Border Payments and Remittances

Beyond trading, cross-border payments and remittances represent one of stablecoins' most transformative applications. The cost advantages are substantial: sending a $200 remittance from Sub-Saharan Africa costs approximately 60% less using stablecoins compared to traditional fiat-based methods. This dramatic cost reduction makes stablecoins attractive to migrant workers and underbanked populations. Strong adoption has followed in Latin America and Sub-Saharan Africa, where stablecoins provide both a hedge against local currency volatility and practical access to USD-denominated value. Geographic adoption data shows these regions experiencing over 40% year-over-year growth in retail and professional-sized stablecoin transfers.

#### Store of Value in High-Inflation Regions

Stablecoins also serve as a critical store of value in regions facing economic instability or high inflation. They allow individuals and businesses to preserve purchasing power when local currencies become unreliable. This use case has proven especially significant in countries experiencing monetary instability, where stablecoins often trade at premiums reflecting users' willingness to pay for stability and faster money movement. Turkey leads the world in stablecoin trading volume as a percentage of GDP. Meanwhile, countries across the Middle East and North Africa are seeing stablecoins capture larger market shares than traditionally dominant cryptocurrencies like Bitcoin and Ethereum.

#### Institutional Adoption

The institutional adoption of stablecoins has reached new heights. Banks and financial institutions increasingly integrate them into operations for liquidity management, settlement mechanisms, and as entry points into cryptocurrency markets. Major payment processors including Stripe, Mastercard, and Visa have launched products enabling users to spend stablecoins through conventional payment rails. This infrastructure has enabled cross-border investment applications through tokenized assets. Investors now swap into stablecoins to access tokenized U.S. Treasury funds like Franklin's BENJI, BlackRock's BUIDL, and Ondo's OUSG, enabling 24/7 settlement capabilities. (These tokenized treasuries are discussed in more detail in Section II of this chapter.)

#### Looking Forward

While trading and arbitrage continue to dominate global stablecoin flows, the infrastructure is expanding into broader economic applications. The significant growth in retail usage across high-inflation economies, combined with emerging institutional applications through tokenized assets, signals an important shift. Stablecoins are transitioning from primarily serving sophisticated financial players toward becoming genuine alternatives to incumbent banking systems, especially in regions where legacy infrastructure fails to meet local needs.

## Section III: Real World Assets

While stablecoins proved that blockchains could handle money, Real World Asset (RWA) **tokenization** represents the next step: moving conventional financial assets on-chain to provide greater efficiency, transparency, and global accessibility than off-chain rails.

The shift is already underway. Incumbent financial giants like BlackRock, Franklin Templeton, and JPMorgan have launched tokenized products that now handle billions in assets and daily volumes. JPMorgan's Kinexys platform processes daily volumes exceeding $2 billion, powering short-term collateralized lending between institutions and tokenized settlement processes. What began as crypto-native experiments has now attracted the world's largest asset managers.

RWA tokenization spans the full spectrum of established markets, ranging from U.S. Treasury bills to complex private credit arrangements, with real estate, stocks, and commodities bridging the gap between these extremes.

The tokenization process requires four critical components that work together to create a functional system. The legal structure forms the foundation through legal wrappers, typically **Special Purpose Vehicles (SPVs)** or trusts, that hold the underlying assets while protecting them from bankruptcy risks. On-chain management utilizes smart contracts to manage ownership records and handle distributions automatically, replacing traditional back-office processes. Data bridges play a crucial role as oracles (the verification infrastructure detailed in Chapter VII) bring real-world asset prices and performance data into blockchain systems. Finally, regulatory compliance infrastructure enforces regulatory requirements while preserving the programmable nature of blockchain transactions.

Additionally, U.S. registered investment funds must maintain a dedicated transfer agent. This agent keeps official shareholder records and processes all distributions and redemptions according to regulatory standards.

As of early 2026, approximately $21 billion worth of RWAs (excluding stablecoins) have been issued on-chain, with participation from more than 200 different issuers. The market breakdown shows about $9 billion in U.S. Treasury Debt, $4 billion in commodities and another $2.5 billion in private credit. The majority of these RWAs are issued on Ethereum.

### Regulatory Framework

RWA tokenization operates at the complex intersection of securities law and digital assets. Most RWA tokens qualify as securities under U.S. law, but rather than pursue expensive public registrations, protocols use regulatory workarounds that enable innovation while limiting mainstream adoption.

The most common approach is Regulation D private placements (limited to accredited investors) or Regulation S offshore offerings (excluding U.S. persons). This regulatory arbitrage creates both opportunities and constraints that shape how protocols operate in practice.

Most protocols implement compliance as code: a comprehensive infrastructure stack that embeds regulatory requirements across multiple layers rather than relying on manual oversight. This multi-layered compliance architecture represents the invisible regulatory plumbing that makes tokenization legally viable while attempting to preserve programmability.

At the token level, standardized smart contract frameworks encode transfer restrictions and compliance checks directly into the tokens themselves. These tokens can programmatically enforce whitelisting (only approved addresses), lock-up periods, and accredited investor requirements. At the platform level, services like Securitize provide the operational infrastructure, handling KYC/AML verification, investor accreditation, ongoing regulatory reporting, and automatic transaction monitoring. Increasingly, compliance portability operates at the wallet level through verifiable credentials and attestations, enabling investors to reuse KYC/AML proofs across venues without fragmenting liquidity.

### Treasury and Fixed Income

Tokenized Treasuries became RWA's first major success story because they solve a clear problem: DeFi protocols needed high-quality, yield-bearing collateral that wasn't subject to crypto volatility. U.S. Treasury bills offer the perfect combination of safety, liquidity, and yield, but legacy financial systems made them difficult to access programmatically.

BlackRock's BUIDL fund represents a watershed moment: the world's largest asset manager offering a tokenized money market fund that accrues income daily and pays distributions in-kind as additional BUIDL tokens. The fund surpassed $2 billion in assets under management by April 2025, demonstrating institutional demand for tokenized Treasury exposure. Franklin Templeton's FOBXX went further, becoming the first U.S.-registered mutual fund to record transactions and share ownership on a public blockchain rather than just tokenizing claims.

The mechanics vary but follow similar patterns. Some protocols use daily net asset value updates with redemption windows, while others employ continuous pricing through authorized market makers. Ondo Finance pioneered widely-used tokenized Treasuries (OUSG for institutional investors meeting high net worth thresholds) and yield-bearing cash equivalents (USDY/rUSDY for broader access), bridging institutional and retail markets with around-the-clock on- and off-ramping capabilities.

Other notable issuers/operators include Superstate (tokenized short-term government funds), Backed (tokenized ETFs and bonds), and Hashnote.

Because RWA tokens are programmable, they can be reused across DeFi protocols, posted as collateral while still earning underlying yield. New institutional venues like Aave Horizon allow qualified users to borrow against tokenized Treasuries and other debt instruments, improving capital efficiency compared to traditional finance workflows.

Corporate bonds and private credit represent the next frontier for fixed income tokenization. Platforms like Centrifuge and Maple Finance facilitate on-chain lending to real-world borrowers, but must navigate complex credit assessment, legal documentation, and default resolution processes. The challenge isn't technical but rather operational, requiring traditional finance expertise alongside blockchain integration.

### Tokenized Stocks

While fixed income tokenization focuses on debt instruments, equity markets represent another major category of conventional assets moving on-chain. The technical implementation, however, varies dramatically depending on how issuers bridge the gap between blockchain records and traditional securities infrastructure.

Tokenized stocks and ETFs are emerging through three distinct architectural approaches. The key distinction lies in whether the token represents a claim on shares held by someone else, or whether the token itself is the actual security. Each approach offers different trade-offs between ease of implementation, regulatory complexity, and integration with existing markets.

The first model, wrapper tokenization (issuer- or SPV-backed), operates similarly to fiat-backed stablecoins but for equities. A non-broker issuer acquires a basket of underlying securities, such as 100 stocks or an ETF, and issues tokens representing claims on the pooled assets. These tokens are economically linked to the underlying securities but are not the same security themselves. Investors redeem tokens with the issuer rather than holding native shares at a brokerage. This structure typically relies on Reg D/Reg S or other jurisdictional exemptions and includes transfer restrictions and whitelisting. Operators like Backed and WisdomTree use this approach, offering on-chain claims on traditional funds. The advantage is speed to market, but the limitation is clear: tokens exist as claims on the wrapper entity rather than direct ownership of the underlying security.

The second approach, wrapper via broker-dealer (brokerage receipts), places a regulated broker-dealer or custody platform at the center of the architecture. The broker maintains the canonical brokerage record and issues on-chain receipts representing customers' brokerage balances. These tokens function as transferable claims inside the broker's ledger, typically limited to eligible, often non-U.S., users and whitelisted wallets. Settlement and finality depend on the broker's books, with the on-chain balance mapping to the broker's internal account structure. Think brokerage-led programs where investors can move balances on-chain, but the underlying asset remains a brokerage entitlement, not a standalone, depositable share. This model inherits broker protections and regulatory infrastructure but constrains composability to the broker's ecosystem.

The third and most ambitious model, canonical tokenization, attempts to make the on-chain instrument the same security as the off-chain share. The token carries the same official security identifier as traditional shares, requiring coordination with the issuer, transfer agent, and market infrastructure. Investors can theoretically bridge positions between their brokerage account and an on-chain wallet, with the transfer agent maintaining authoritative records across both environments. Superstate exemplifies this approach, pursuing true security tokenization rather than wrapper claims. This model leverages standardized compliance-focused token frameworks and transfer-agent integration, unlocking fungibility with traditional markets. However, it requires deep integration with issuers, transfer agents, and venue rules, making it the most operationally complex path.

Each model represents different compromises. Wrappers ship fastest but create new securities that are merely claims on underlying assets. Broker-led receipts inherit existing regulatory frameworks and investor protections but remain confined to brokerage ecosystems. Canonical tokens promise true interoperability between traditional and blockchain markets but demand infrastructure integration that most issuers aren't prepared to undertake.

Adoption remains limited across all three models, with BlackRock's reported interest in tokenizing ETFs representing perhaps the most significant validation. Current use cases focus on institutional portfolio rebalancing, collateralization, and programmable settlement rather than retail trading, constrained by the secondary market liquidity challenges discussed below.

### Physical Assets

While tokenized financial instruments have gained traction, physical asset tokenization remains largely experimental. Real estate and commodities represent the most prominent categories, but both face fundamental challenges that limit their practical adoption.

Real estate tokenization promises to democratize property investment. Instead of needing hundreds of thousands to buy a rental property, investors could own $1,000 worth of a diversified portfolio and receive proportional rental income. Early platforms tokenize individual properties, with each token representing LLC shares in the underlying asset. However, three critical hurdles limit real estate tokenization in practice. First, properties require regular appraisals to maintain accurate valuations, creating ongoing costs and potential disputes. Second, operational management remains complex: someone must handle property maintenance, tenant relations, and local regulatory compliance. Third, the liquidity challenges discussed below have prevented meaningful secondary markets from developing. These obstacles have prevented real estate tokenization from scaling beyond niche applications.

Commodity tokenization confronts similar bridging problems between physical and digital worlds. Pax Gold (PAXG) represents actual gold bars stored in Brink's vaults, with each token backed by one troy ounce of investment-grade gold. Tether Gold (XAUT) offers similar exposure through different custody arrangements. These products must navigate storage costs, insurance, audit verification, and redemption logistics. Holding PAXG theoretically represents ownership of real gold, but accessing that gold requires navigating complex custody and shipping arrangements. The result is that commodity tokens primarily serve as a way to gain price exposure without the complexities of physical ownership.

Across both categories, a fundamental tension emerges: tokenization can improve record-keeping and fractional ownership, but it cannot eliminate the operational complexity of managing physical assets. The technology provides better rails for tracking ownership, yet the underlying assets remain subject to the same liquidity constraints, management requirements, and coordination challenges that have always made physical assets difficult to securitize. Until these operational hurdles are addressed through new business models or regulatory frameworks, physical asset tokenization will likely remain a niche application rather than a mainstream investment category.

### Market Infrastructure

Tokenization promises improved liquidity for conventionally illiquid assets, but this promise hasn't materialized. The result is a paradox: tokens designed to make illiquid assets more tradeable often lack meaningful secondary markets themselves.

Established securities benefit from mature exchanges, professional market makers, and deep institutional participation. Tokenized RWAs often trade on decentralized exchanges with minimal liquidity or private markets with restricted access. The problem manifests differently across asset classes but with consistent results: tokenized real estate properties might trade only a few times per month, commodity tokens serve primarily as price exposure instruments rather than facilitating physical delivery, and tokenized stocks see activity focused on institutional portfolio rebalancing rather than retail participation.

The fundamental challenge is that tokenization solves record-keeping but not price discovery or market coordination. A building cannot be instantly converted to cash regardless of whether ownership is recorded on-chain or in a county registry. Gold bars still require custody, insurance, and shipping logistics. Regulatory restrictions on equity trading persist whether shares exist as tokens or traditional securities.

This liquidity challenge means that many RWA tokens function more like conventional private placements than the liquid, tradeable assets their proponents envision. Secondary market liquidity remains the Achilles' heel of RWA tokenization, suggesting that improved infrastructure alone cannot manufacture the network effects and institutional participation that create deep markets.