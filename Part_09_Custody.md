# Part IX: Custody (Expert Essentials)

*This chapter introduces the core ideas behind institutional crypto custody. The goal is clarity: understand what controls actually prevent loss, how policy and evidence make custody professional, and how to choose the right model for your use case.*

## Chapter 41: Custody Fundamentals

Crypto turns value into information. That shift eliminates trucks and vaults but replaces them with a new reality: **keys = control**. If a party can authorize a transaction, they effectively own the asset. Most failures in custody are not cryptographic—they are **policy failures**: approvals granted too easily, segregation blurred, evidence missing. Professional custody is a discipline of **least hotness** (keep the minimum online), engineered **recovery**, and **provable operations**.

The right question is not “Is it air‑gapped?” but “Can we prove how keys were created, who can move funds, and what evidence shows the rules were followed?” If you can’t show it, it didn’t happen.

### Threats and First Principles

Threats cluster into four buckets. **External** attackers exploit phishing, malware, exchange and bridge weaknesses, and sometimes state‑level capabilities. **Insider** risk hides in privileged access and convenient policy downgrades. **Operational** failures include lost shards, untested disaster recovery, and weak change management. **Legal/Jurisdictional** risks include seizures, sanctions, disclosure regimes, and capital controls.

First principles are simple. Use layered controls so one mistake cannot cause a total loss. Keep most value **cold**, a small buffer **warm**, and the minimum **hot**. Engineer **freeze and rotation** for emergencies. Produce **immutable evidence**—attestations, logs, and audits—to prove what happened.

### Custody Models

**Multisig (on‑chain rules).** Policy is enforced by the blockchain. It is transparent, open‑source, and easy to audit, which makes it excellent for DeFi and governance. The trade‑offs are higher fees and public policy structure. This model shines for DAOs and protocol treasuries.

**MPC / Threshold Signatures (off‑chain quorum).** Multiple parties jointly produce a signature without ever reconstructing a single private key. Approvals are fast, policies are private, and support is chain‑agnostic. The risk shifts to platform and vendor quality, so evidence and logging must be strong. This model fits trading desks and multi‑chain operations.

**Qualified Custodian (regulated bank/trust).** Legal segregation, examiner oversight, and insurance. Processes are slower and DeFi composability is limited, but fiduciaries often require this route. Suitable for institutions with regulatory obligations.

**Smart‑contract wallets (account abstraction).** Programmable policy, social recovery, and gas abstraction in EVM environments. The trade‑offs are contract risk and evolving standards.

### Controls That Matter

Everything starts at key generation. In institutional settings, best practice is to use **HSMs** or attested secure enclaves, often targeting **FIPS 140‑3 Level 3**. Custody programs generally implement **split knowledge** and **dual control** so no single person can act alone. These controls are typically backed by a **policy engine** providing role‑based access, quorum approvals, velocity and value caps, allowlists, time‑locks, and change‑control with multi‑party approval.

Evidence is the difference between intention and reality. Industry practice emphasizes **immutable logs (WORM)** with NTP‑synced timestamps, device attestations, signer participation, and complete approval trails exported to a **SIEM**. Disaster‑recovery programs commonly include **geo‑distributed shards**, regularly tested runbooks, defined **RTO/RPO**, and an **emergency freeze and expedited rotation** capability.

**Segregation and tiering** by value are standard. Many programs target cold ≥90%, warm ~5–10%, hot <5%, enforce ceilings (not just targets), and reconcile continuously.

> Controls callouts:
> - Key ceremony & attestation: typically witnessed and recorded; devices use measured boot; logs are hash‑chained and anchored externally.
> - Admin‑plane dual control: common patterns include JML (joiner–mover–leaver), two‑person rules for policy changes, and break‑glass with timelock/duress.
> - Production isolation: many programs operate a dedicated signing network, one‑way data flow for cold paths, and firmware pinning with SBOM.
> - Provider exit plan: mature setups support MPC share export/refresh, BYO‑HSM options, and independent escrowed recovery.
> - Legal posture: frameworks address bankruptcy remoteness/title, segregation models, sanctions/Travel Rule, and key‑location jurisdiction.
> - Assurance & insurance: auditor attestations (SOC 2/ISO) and red‑team exercises; crime/specie cover with sub‑limits across hot/warm/cold.
> - Independent reconciliation & proofs: operations include daily reconciliation to customer ledgers and periodic proof‑of‑assets/liabilities (client‑verifiable).

### Mnemonic Seed Phrases vs Multisig

Mnemonic seed phrases (BIP‑39) are human‑readable encodings of cryptographic entropy. Valid lengths are 12, 15, 18, 21, or 24 words. The words encode entropy plus a checksum; combined with an optional passphrase (the “25th word”), they are stretched (PBKDF2) into a master seed from which hierarchical wallets (BIP‑32/44) derive accounts and addresses. Anyone who learns the mnemonic and passphrase can deterministically recreate all derived keys and control funds.

Key implications:
- Single‑signer root: a mnemonic is one secret. It is fast and portable but a single point of failure. Loss or exposure equals total loss of control.
- Hardening: generate and verify on hardware wallets/HSMs, consider a passphrase, store offline (e.g., metal backup), and periodically test restores. If removing single‑point risk is required, use multisig or Shamir backup.

How this differs from multisig:
- Policy location: a mnemonic encodes a single key; any “policy” is off‑chain and social. Multisig enforces policy on‑chain (Bitcoin/EVM) with M‑of‑N keys.
- Failure domains: mnemonic = one secret to protect; multisig = several independent keys, requiring a quorum to spend.
- Recovery: mnemonic restore needs the one phrase (and passphrase); multisig recovery requires the threshold number of distinct keys/seed backups.
- On‑chain footprint: multisig is visible on‑chain (e.g., Bitcoin scripts, EVM contracts like Safe), while a single mnemonic signs normal single‑sig transactions.

High‑level entropy and quantum context:
- Word counts and entropy: 12, 15, 18, 21, and 24 words correspond to ~128, 160, 192, 224, and 256 bits of entropy. The BIP‑39 list has 2048 words (2^11), so each word carries 11 bits. A short checksum (ENT/32 bits; e.g., 4 bits for 12‑word) is appended to catch errors, yielding 12×11=132 total bits for a 12‑word phrase.
- Today vs longevity: 128‑bit entropy is strong for today’s classical security. For multi‑decade or generational horizons, prefer 24 words (≈256‑bit entropy) and/or add a strong passphrase to materially raise brute‑force cost.
- Quantum risk: Mnemonics protect against guessing. A future Grover‑style quadratic speedup would make brute‑forcing 128‑bit feel like ~64‑bit and 256‑bit like ~128‑bit—still astronomically hard at those levels. The bigger quantum risk is to signature schemes (e.g., ECDSA/EdDSA) via Shor’s algorithm, which could recover private keys from public keys once revealed on‑chain.
- Practical guardrails: avoid address reuse so public keys are not exposed until spend; favor 24 words + high‑entropy passphrase for long‑term storage; plan to migrate to post‑quantum‑safe wallets when mature.
- Multisig and quantum: multisig reduces single‑point and insider risk but does not eliminate Shor’s risk—each signer key is still ECDSA/EdDSA today. It remains valuable for operational resilience while the ecosystem transitions to post‑quantum primitives.

### DeFi and Asset Nuances

DeFi approvals are the most common institutional trap. Avoid **infinite allowances**, simulate transactions before signing, maintain allowlists, and defend against **address poisoning**. On **Bitcoin**, UTXO consolidation improves operations but can reduce privacy; use **PSBT** workflows and consider **Taproot/muSig** for scalable multi‑party policies. On **Ethereum and L2s**, separate **validator** and **withdrawal** credentials, assess bridge trust assumptions, and consider private relays for sensitive flows.

### Exchange Plumbing and Proof‑of‑Reserves

When assets sit on an exchange, you inherit the exchange’s solvency and operations risk. The practical “plumbing” that makes balances real includes how wallets are tiered across hot, warm, and cold storage, how margin and borrow/lend are accounted for, whether collateral is rehypothecated, and how losses are socialized through insurance funds and auto‑deleveraging in stress.

“Proof‑of‑reserves” (PoR) is how an exchange demonstrates solvency. A useful PoR pairs on‑chain or custodian‑verified asset attestations with client‑verifiable liability proofs (so each customer can check inclusion and totals), clear exclusion proofs, and a published scope and cadence overseen by an independent party. Asset‑only snapshots, vague scopes, or one‑off announcements are not sufficient for professional assurance.

### Choosing a Path

DAO and protocol teams typically use **Safe** on EVM for transparent governance and DeFi access, sometimes pairing it with a qualified custodian for strategic reserves. Active trading firms benefit from **MPC platforms** (e.g., Fireblocks, Copper) for speed and exchange connectivity while parking long‑term assets with a qualified custodian. Regulated funds and companies usually prefer **Anchorage**, **BitGo**, or **Coinbase Custody** as primary custodians and add MPC where policy allows.

### Lessons from Incidents

Failures rhyme. **Mt. Gox** blurred hot and cold and lacked reconciliation. **Parity Multisig** revealed the risk of upgrade paths and shared libraries. **Ronin** concentrated validator control and missed anomaly detection. **FTX** commingled customer and proprietary assets. The lesson is consistent: enforce segregation, harden policy change, monitor for anomalies, and keep independent evidence.

## Key Takeaways
- Custody hinges on "keys = control"; losses often arise from policy/operations rather than cryptography.
- Threats span external, insider, operational, and legal/jurisdictional categories.
- Custody models: multisig (on‑chain policy), MPC (off‑chain quorum), qualified custodians, and smart‑contract wallets—each with distinct transparency, speed, regulatory, and composability trade‑offs.
- Core controls: hardware‑backed key generation, split knowledge/dual control, policy engines (roles/quorums/limits), immutable evidence, and tested disaster recovery.
- Segregation by value uses cold/warm/hot tiering with ceilings and continuous reconciliation concepts.
- Mnemonics (BIP‑39): 12/15/18/21/24 words encode entropy plus checksum; optional passphrase; hierarchical derivation. Single‑seed wallets differ from multisig in policy location and failure domains.
- Quantum context: Grover affects brute‑force search over seed space; Shor targets current signature schemes when public keys are exposed; long‑term posture involves migration to post‑quantum primitives at the ecosystem level.
- Incident patterns: blurred segregation, fragile upgrade paths, concentrated control, and commingling emphasize segregation, change‑control rigor, anomaly detection, and independent evidence.