# Part IX: Custody (Expert Essentials)

*This chapter introduces the core ideas behind institutional crypto custody. The goal is clarity: understand what controls actually prevent loss, how policy and evidence make custody professional, and how to choose the right model for your use case.*

## Chapter 35: Custody Fundamentals

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

Everything starts at key generation. Use **HSMs** or attested secure enclaves and target **FIPS 140‑3 Level 3** for institutional settings. Enforce **split knowledge** and **dual control** so no single person can act alone. Back this with a **policy engine**: role‑based access, quorum approvals, velocity and value caps, allowlists, time‑locks, and change‑control with multi‑party approval.

Evidence is the difference between intention and reality. Keep **immutable logs (WORM)** with NTP‑synced timestamps, device attestations, signer participation, and complete approval trails exported to a **SIEM**. Disaster recovery should be routine: **geo‑distributed shards**, tested runbooks, defined **RTO/RPO**, and an **emergency freeze and expedited rotation**.

Practice **segregation and tiering** by value. A common target is cold ≥90%, warm ~5–10%, hot <5%. Enforce ceilings—not just targets—and reconcile continuously.

### DeFi and Asset Nuances

DeFi approvals are the most common institutional trap. Avoid **infinite allowances**, simulate transactions before signing, maintain allowlists, and defend against **address poisoning**. On **Bitcoin**, UTXO consolidation improves operations but can reduce privacy; use **PSBT** workflows and consider **Taproot/muSig** for scalable multi‑party policies. On **Ethereum and L2s**, separate **validator** and **withdrawal** credentials, assess bridge trust assumptions, and consider private relays for sensitive flows.

### Choosing a Path

DAO and protocol teams typically use **Safe** on EVM for transparent governance and DeFi access, sometimes pairing it with a qualified custodian for strategic reserves. Active trading firms benefit from **MPC platforms** (e.g., Fireblocks, Copper) for speed and exchange connectivity while parking long‑term assets with a qualified custodian. Regulated funds and companies usually prefer **Anchorage**, **BitGo**, or **Coinbase Custody** as primary custodians and add MPC where policy allows.

### Lessons from Incidents

Failures rhyme. **Mt. Gox** blurred hot and cold and lacked reconciliation. **Parity Multisig** revealed the risk of upgrade paths and shared libraries. **Ronin** concentrated validator control and missed anomaly detection. **FTX** commingled customer and proprietary assets. The lesson is consistent: enforce segregation, harden policy change, monitor for anomalies, and keep independent evidence.

## Key Takeaways
- Keys are control; policy and evidence are the real safeguards.
- Keep assets least‑hot: cold dominant, warm buffered, hot minimal.
- Choose the model that matches your obligations and latency needs.
- Engineer freeze and rotation before you need them.
- If you can’t prove it, it didn’t happen.

## Minimal Reading List
- BIP‑32/39/44 (HD wallets, mnemonics), BIP‑174 (PSBT)
- BIP‑340‑342 (Schnorr/Taproot), MuSig2 (multi‑signatures)
- EIP‑4337 (Account Abstraction), EIP‑2333/2334 (BLS derivation)
- FIPS 140‑3 (HSM certification), SOC 2 Type II, ISO/IEC 27001
