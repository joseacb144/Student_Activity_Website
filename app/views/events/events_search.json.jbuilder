json.items @events do |item|
	json.partial! "events/event", event: item
end