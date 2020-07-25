module ApplicationHelper

	def datepicker_field(form, field)
		dateFormat = t'date.format.short'
	    form.text_field(field, class:"form-control datepicker", data: { provide: "datepicker",
	      'date-format': 'yyyy/mm/dd',
	      'date-autoclose': 'true',
	      'date-today-btn': 'linked',
	      'date-today-highlight': 'true'}, value: form.object[field] ? form.object[field].strftime(dateFormat) : nil,
	      required:true
	      ).html_safe
	end
end
