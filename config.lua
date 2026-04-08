Config = Config or {}

Config.EvidenceStorage = {
    Enabled = true,

    Zones = {
        mrpd = {
            points = {
                vec3(481.775, -989.112, 24.916)
            },
            thickness = 4.0
        }
    },

    AutoBonusPayoutTimer = 90000,
    AccidentWithdrawTimer = 15000,
    PayoutMultiplier = 1.0,

    ItemPayouts = {
        DEFAULT = { price = 10 },
        money = { price = 0 },
        black_money = { price = 0.5 },

        WEAPON_COMPACTRIFLE = { price = 25000 },
        WEAPON_MACHETE = { price = 1000 },
        WEAPON_HATCHET = { price = 1000 },
        WEAPON_KNIFE = { price = 200 },
        WEAPON_SWITCHBLADE = { price = 400 },
        WEAPON_BOTTLE = { price = 200 },
        WEAPON_MOLOTOV = { price = 1000 },
    }
}