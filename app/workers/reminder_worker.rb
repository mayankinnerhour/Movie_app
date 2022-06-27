# class ReminderWorker
# 	include sidekiq:Worker

# 	def perform()
# 		# after_create :reminder

# 	def reminder
# 		time_str = ((self.time).localtime).strftime("%I:%M%p on %b. %d, %Y")
# 		message = "Hi #{self.name}. Just a reminder that you have an appointment coming up at #{time_str}."
# 		slack_data = { message: message }
# 		sendNotification(slack_data)
# 	end

# 	def when_to_run
# 		minutes_before_appointment = 1.minutes
# 		time - minutes_before_appointment
# 	end
		
# 	end
# end