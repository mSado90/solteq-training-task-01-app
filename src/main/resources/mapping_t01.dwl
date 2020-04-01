%dw 2.0
output application/json
var payloadOrdered = payload orderBy ($.shopId)
---

payloadOrdered map (item, ind) -> {
	id: item.shopId,
	name: item.displayName,
	(address: item.streetAddress ++ ', ' ++ item.zip ++ ' ' ++ item.city)
		if (not (isEmpty(item.streetAddress) or isEmpty(item.zip))),
	openingHours: item.shopOpeningHours[0] filterObject $$$ > 2 mapObject {
		(Monday: $  ++ '-' ++ payloadOrdered[ind].shopOpeningHours.monEndTime[0]) 
			if (($$$ == 0) and payloadOrdered[ind].shopOpeningHours.monEndTime[0] != null),
		(Tuesday: $ ++ '-' ++ payloadOrdered[ind].shopOpeningHours.tueEndTime[0]) 
			if (($$$ == 2) and payloadOrdered[ind].shopOpeningHours.tueEndTime[0] != null),
		(Wednesday: $ ++ '-' ++ payloadOrdered[ind].shopOpeningHours.wedEndTime[0]) 
			if (($$$ == 4) and payloadOrdered[ind].shopOpeningHours.wedEndTime[0] != null),
		(Thursday: $ ++ '-' ++ payloadOrdered[ind].shopOpeningHours.thuEndTime[0])
			if (($$$ == 6) and payloadOrdered[ind].shopOpeningHours.thuEndTime[0] != null),
		(Friday: $ ++ '-' ++ payloadOrdered[ind].shopOpeningHours.friEndTime[0])
			if (($$$ == 8) and payloadOrdered[ind].shopOpeningHours.friEndTime[0] != null),
		(Saturday: $ ++ '-' ++ payloadOrdered[ind].shopOpeningHours.satEndTime[0])
			if (($$$ == 10) and payloadOrdered[ind].shopOpeningHours.satEndTime[0] != null),
		(Sunday: $ ++ '-' ++ payloadOrdered[ind].shopOpeningHours.sunEndTime[0])
			if (($$$ == 12) and payloadOrdered[ind].shopOpeningHours.sunEndTime[0] != null),
	},
	offersDelivery: item.hasDelivery
}