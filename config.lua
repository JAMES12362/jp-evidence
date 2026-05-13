Config = Config or {}

Config.EvidenceStorage = {
    Enabled = true,

    EvidenceItem = 'police_evidence',
    EvidenceLabel = 'Police Evidence',

    WithdrawGrade = 7,

    Slots = 50,
    Weight = 100000,

    AutoBonusPayoutTimer = 90000,
    AccidentWithdrawTimer = 15000,
    PayoutMultiplier = 1.0,

    Zones = {
        mrpd = {
            stash = 'pdbonus_mrpd',
            coords = vector3(481.775, -989.112, 25.916),

            drawDistance = 10.0,
            interactDistance = 1.5,

            markerType = 2,
            markerSize = vec3(0.35, 0.35, 0.35),
            markerColor = { r = 50, g = 150, b = 255, a = 180 }
        },

        --[[
        mrpd_second = {
            stash = 'pdbonus_mrpd',
            coords = vector3(475.123, -992.456, 24.916),

            drawDistance = 10.0,
            interactDistance = 1.5,

            markerType = 2,
            markerSize = vec3(0.35, 0.35, 0.35),
            markerColor = { r = 50, g = 150, b = 255, a = 180 }
        }
        ]]
    },

    ItemPayouts = {
        -- LIST ALL ITEMS WHICH WILL BE CONFISCATED / ILLEGAL.
        black_money = { price = 0.5 },
        WEAPON_COMPACTRIFLE = { price = 25000 },
        WEAPON_MACHETE = { price = 1000 },
        WEAPON_HATCHET = { price = 1000 },
        WEAPON_KNIFE = { price = 200 },
        WEAPON_SWITCHBLADE = { price = 400 },
        WEAPON_BOTTLE = { price = 200 },
        WEAPON_MOLOTOV = { price = 1000 }
    }
}
