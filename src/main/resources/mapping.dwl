%dw 2.0
output application/json
---
payload map (item, ind) -> {
	id: item.shopId,
	name: item.displayName,
	(address: item.streetAddress ++ ', ' ++ item.zip ++ ' ' ++ item.city)
		if (not (isEmpty(item.streetAddress) or isEmpty(item.zip))),
	openingHours: item.shopOpeningHours[0] filterObject $$$ > 2 mapObject {
		(Monday: $ ++ '-' ++ payload[ind].shopOpeningHours.monEndTime[0]) if ($$$ == 0),
		(Tuesday: $ ++ '-' ++ payload[ind].shopOpeningHours.tueEndTime[0]) if ($$$ == 2),
		(Wednesday: $ ++ '-' ++ payload[ind].shopOpeningHours.wedEndTime[0]) if ($$$ == 4),
		(Thursday: $ ++ '-' ++ payload[ind].shopOpeningHours.thuEndTime[0]) if ($$$ == 6),
		(Friday: $ ++ '-' ++ payload[ind].shopOpeningHours.friEndTime[0]) if ($$$ == 8),
		(Saturday: $ ++ '-' ++ payload[ind].shopOpeningHours.satEndTime[0]) if ($$$ == 10),
		(Sunday: $ ++ '-' ++ payload[ind].shopOpeningHours.sunEndTime[0]) if ($$$ == 12),
	},
	offersDelivery: item.hasDelivery
}


