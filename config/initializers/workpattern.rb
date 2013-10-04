Houston::Application.config.workpattern = Workpattern.new('Houston Incedents Workpattern', 2013, 01)
Houston::Application.config.workpattern.resting(days: :weekend) # выходные
Houston::Application.config.workpattern.resting(days: :weekday, from_time: Workpattern.clock(0, 0), to_time: Workpattern.clock(8, 59)) # ночь
Houston::Application.config.workpattern.resting(days: :weekday, from_time: Workpattern.clock(13, 0), to_time: Workpattern.clock(13, 59)) # обед
Houston::Application.config.workpattern.resting(days: :weekday, from_time: Workpattern.clock(18, 0), to_time: Workpattern.clock(23, 59)) # вечер