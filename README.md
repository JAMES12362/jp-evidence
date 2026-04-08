# jp-evidence
### Description
JP Evidence allows police officers to receive a bonus for their hard work!

The script uses a shared evidence stash where officers can deposit seized items. Every set interval, the stash is processed, the total value is calculated, and the payout is split between all on-duty police.

[Discord/ Support] -- Feel free to add me on discord, until I get something setup!

## Install:
Drag and drop the folder into your resources folder (or equivalent) and ensure it in your server.cfg.

You must also create a stash in your existing stash system (ox_inventory compatible) with a matching name (e.g. `pdbonus_mrpd`).

Tested with Qbox and confirmed WORKING!

## Notes:

- This script uses a **shared stash**, not per-player stashes.
- All evidence deposited is pooled together and paid out evenly to on-duty officers.
- The stash is automatically processed and cleared on a repeating timer.
- Withdrawals can be restricted by police grade (e.g. only ranks 7+ can withdraw).
- Stash names should NOT use `evidence_*` as this conflicts with ox_inventory internals. -- IF NAME evidence_pd you will keep getting kicked upon opening the stash!
- Use names like `pdbonus_mrpd`, `pdbonus_sandy`, etc.

## Dependencies:
- ox_lib
- ox_inventory
- qbx_core

## Support:


## Buy Me a Coffee:
If you enjoy my work feel free to buy me a coffee :)

www.buymeacoffee.com/jayeepeegaming