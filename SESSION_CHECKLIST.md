# Stablecoin Session Checklist

## 1. Problem
- [x] I can explain why a stablecoin contract needs `mint` and `burn`.
- [ ] I can explain who is allowed to call each function.
- [ ] I can explain what would break if either function were missing.

## 2. Solution
- [x] I understand what `mint` should do in business terms.
- [x] I understand what `burn` should do in business terms.
- [ ] I can explain the edge cases for both functions.
- [ ] I can explain why access control matters here.

## 3. Broader Context
- [x] I understand how these functions affect supply.
- [x] I understand why supply changes matter for a stablecoin.
- [ ] I can connect this to testing and TDD.

## 4. Stablecoin Economics
- [x] I can explain why `mint` and `burn` alone do not magically hold the price.
- [ ] I can distinguish fiat-backed, crypto-backed, and algorithmic stablecoins.
- [x] I can explain collateralization, overcollateralization, redemption, arbitrage, liquidation, and peg.
- [x] I can explain why oracle prices and liquidations are critical in crypto-backed stablecoins.
- [ ] I can describe at least one failure mode for each stablecoin design.

## 5. Crypto-Backed Stablecoins Deep Dive
- [x] I can explain the core problem: volatile collateral backing a stable debt token.
- [x] I can explain why overcollateralization exists.
- [x] I can calculate a basic collateral ratio from collateral value and minted stablecoin debt.
- [x] I can explain what happens when collateral price rises.
- [x] I can explain what happens when collateral price falls.
- [x] I can explain why liquidation exists and who is incentivized to liquidate.
- [x] I can explain why an oracle is needed.
- [x] I can explain how `mint` creates debt, not free money.
- [x] I can explain how `burn` usually repays debt and reduces supply.
- [x] I can explain how market arbitrage helps restore the peg.
- [x] I can name failure modes: oracle failure, liquidity shortage, liquidation cascade, governance risk, smart contract bug.

## Current Focus
- [x] Restate how you currently think crypto-backed stablecoins work.
- [x] Explain the problem overcollateralization is solving.
- [x] Walk through one numeric example of minting and liquidation.

## Stage 1: Volatile Collateral
- [x] I understand that minted stablecoins are debt against collateral.
- [x] I understand that collateral value can fall while debt stays the same.
- [x] I understand why a 100% collateral ratio is fragile.
- [x] I understand why 150%-200% collateral gives the system a safety buffer.

### Stage 1 Notes
- Core idea: `mint` creates a debt position backed by collateral.
- The debt is denominated in stablecoins and does not automatically fall when ETH falls.
- The collateral value is market-dependent and can fall quickly.
- Example: `$200` collateral and `100` stablecoin debt means a `200%` collateral ratio.
- If collateral falls to `$120` and debt stays `100`, the ratio falls to `120%`.
- This is risky because the system has less buffer before the debt is no longer fully backed.

### Stage 1 Verification Prompt
Answer in your own words:

```text
Pozycja robi się bardziej ryzykowna, bo...
```

## Stage 2: Liquidation Mechanics
- [x] I understand what threshold makes a position liquidatable.
- [x] I understand who can call liquidation, including permissionless liquidation.
- [x] I understand what the liquidator repays.
- [x] I understand what collateral the liquidator receives.
- [x] I understand why a liquidation bonus exists.
- [x] I understand how liquidation improves the protocol's risk after the call.
- [x] I understand what can go wrong if liquidation is too slow or liquidity is missing.

## Stage 3: Oracles
- [x] I understand that market prices are formed outside the stablecoin contract.
- [x] I understand that a smart contract needs an oracle to read an external asset price.
- [x] I understand how oracle price affects collateral ratio and liquidation.
- [x] I understand what can go wrong if the oracle is stale, manipulated, or unavailable.

## Stage 4: TradFi Analogies
- [x] I can compare crypto-backed minting to borrowing against collateral.
- [x] I can compare stablecoin burning to debt repayment and supply reduction.
- [ ] I can explain where the central bank analogy helps.
- [ ] I can explain where the central bank analogy breaks.

## Stage 5: Supply Accounting
- [x] I understand that `totalSupply` should track active minted debt in a debt-backed stablecoin model.
- [x] I understand why repaid debt should usually be burned.
- [x] I understand why unburned repaid tokens can become dangerous if they return to circulation without fresh collateral.

## Stage 6: Peg And Arbitrage
- [x] I understand why a borrower may buy underpriced stablecoins to repay debt.
- [x] I understand how buying underpriced stablecoins can push price back toward peg.
- [x] I understand what can happen when the stablecoin trades above `$1`.
- [x] I understand why arbitrage depends on trust that redemption/repayment works.

## Stage 7: Failure Modes
- [x] I understand why a smart contract bug can be catastrophic.
- [x] I understand why oracle failures can become systemic, not only temporary.
- [x] I understand why slow liquidations can create bad debt.
- [x] I understand how multiple failures can compound during market stress.

## Stage 8: Defense Mechanisms
- [x] I understand why higher collateral ratios reduce risk but reduce capital efficiency.
- [x] I understand how liquidation bonuses and close factors affect liquidator incentives.
- [x] I understand why robust oracle design matters.
- [x] I understand why circuit breakers and debt ceilings can limit damage.
- [x] I understand why debt ceilings limit exposure to risky collateral.
- [x] I understand the tradeoff between safety and usability.

## Stage 9: Algorithmic Stablecoins
- [x] I understand that algorithmic stablecoins try to maintain peg mainly through incentives and supply adjustments.
- [x] I understand why `mint`/`burn` can be used as an incentive mechanism, not a guarantee of value.
- [x] I understand the difference between collateral-backed confidence and reflexive market confidence.
- [ ] I understand why death spirals can happen.
- [ ] I can explain why algorithmic stablecoins are generally riskier than overcollateralized crypto-backed stablecoins.
