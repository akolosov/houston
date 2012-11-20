# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)

Role.create([ { :name => 'admin' }, { :name => 'manager' } ], :without_protection => true)

admin = User.create :username => 'admin', :email => 'admin@test.com', :password => 'admin', :password_confirmation => 'admin'
admin.save
admin.add_role :admin

user = User.create :username => 'manager', :email => 'manager@test.com', :password => 'manager', :password_confirmation => 'manager'
user.save
user.add_role :manager

server1 = Server.create(:name => 'Server #1', :description => 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. In adipiscing, ligula et imperdiet malesuada, arcu quam lacinia lacus, dignissim eleifend enim lorem ac augue. Etiam quis venenatis ipsum. Aliquam sodales diam ac felis dignissim sollicitudin. Proin lacinia condimentum neque. Integer lacinia consequat ipsum, et consequat quam luctus venenatis. Ut tempor convallis sodales. Vivamus blandit diam non diam ornare id dignissim nunc porttitor. Phasellus rutrum, lorem sed congue pharetra, erat augue dignissim dolor, vel fermentum ipsum arcu in sapien.',
          :location => 'Server Room', :address => '192.168.1.1', :username => 'user')
server1.save

server2 = Server.create(:name => 'Server #2', :description => 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. In adipiscing, ligula et imperdiet malesuada, arcu quam lacinia lacus, dignissim eleifend enim lorem ac augue. Etiam quis venenatis ipsum. Aliquam sodales diam ac felis dignissim sollicitudin. Proin lacinia condimentum neque. Integer lacinia consequat ipsum, et consequat quam luctus venenatis. Ut tempor convallis sodales. Vivamus blandit diam non diam ornare id dignissim nunc porttitor. Phasellus rutrum, lorem sed congue pharetra, erat augue dignissim dolor, vel fermentum ipsum arcu in sapien.',
          :location => 'Server Room', :address => '192.168.1.2', :username => 'user')
server2.save

server3 = Server.create(:name => 'Server #3', :description => 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. In adipiscing, ligula et imperdiet malesuada, arcu quam lacinia lacus, dignissim eleifend enim lorem ac augue. Etiam quis venenatis ipsum. Aliquam sodales diam ac felis dignissim sollicitudin. Proin lacinia condimentum neque. Integer lacinia consequat ipsum, et consequat quam luctus venenatis. Ut tempor convallis sodales. Vivamus blandit diam non diam ornare id dignissim nunc porttitor. Phasellus rutrum, lorem sed congue pharetra, erat augue dignissim dolor, vel fermentum ipsum arcu in sapien.',
          :location => 'Server Room', :address => '192.168.1.3', :username => 'user')
server3.save


command1 = Command.create(:name => 'Command #1', :description => 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. In adipiscing, ligula et imperdiet malesuada, arcu quam lacinia lacus, dignissim eleifend enim lorem ac augue. Etiam quis venenatis ipsum. Aliquam sodales diam ac felis dignissim sollicitudin. Proin lacinia condimentum neque. Integer lacinia consequat ipsum, et consequat quam luctus venenatis. Ut tempor convallis sodales. Vivamus blandit diam non diam ornare id dignissim nunc porttitor. Phasellus rutrum, lorem sed congue pharetra, erat augue dignissim dolor, vel fermentum ipsum arcu in sapien.',
          :command => 'this is command #1', :with_params =>true, :confirm =>false)
command1.save

command2 = Command.create(:name => 'Command #2', :description => 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. In adipiscing, ligula et imperdiet malesuada, arcu quam lacinia lacus, dignissim eleifend enim lorem ac augue. Etiam quis venenatis ipsum. Aliquam sodales diam ac felis dignissim sollicitudin. Proin lacinia condimentum neque. Integer lacinia consequat ipsum, et consequat quam luctus venenatis. Ut tempor convallis sodales. Vivamus blandit diam non diam ornare id dignissim nunc porttitor. Phasellus rutrum, lorem sed congue pharetra, erat augue dignissim dolor, vel fermentum ipsum arcu in sapien.',
          :command => 'this is command #2', :with_params =>false, :confirm =>true)
command2.save

command3 = Command.create(:name => 'Command #3', :description => 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. In adipiscing, ligula et imperdiet malesuada, arcu quam lacinia lacus, dignissim eleifend enim lorem ac augue. Etiam quis venenatis ipsum. Aliquam sodales diam ac felis dignissim sollicitudin. Proin lacinia condimentum neque. Integer lacinia consequat ipsum, et consequat quam luctus venenatis. Ut tempor convallis sodales. Vivamus blandit diam non diam ornare id dignissim nunc porttitor. Phasellus rutrum, lorem sed congue pharetra, erat augue dignissim dolor, vel fermentum ipsum arcu in sapien.',
          :command => 'this is command #3', :with_params =>true, :confirm =>false)
command3.save

command4 = Command.create(:name => 'Command #4', :description => 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. In adipiscing, ligula et imperdiet malesuada, arcu quam lacinia lacus, dignissim eleifend enim lorem ac augue. Etiam quis venenatis ipsum. Aliquam sodales diam ac felis dignissim sollicitudin. Proin lacinia condimentum neque. Integer lacinia consequat ipsum, et consequat quam luctus venenatis. Ut tempor convallis sodales. Vivamus blandit diam non diam ornare id dignissim nunc porttitor. Phasellus rutrum, lorem sed congue pharetra, erat augue dignissim dolor, vel fermentum ipsum arcu in sapien.',
          :command => 'this is command #4', :with_params =>false, :confirm =>true)
command4.save

command5 = Command.create(:name => 'Command #5', :description => 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. In adipiscing, ligula et imperdiet malesuada, arcu quam lacinia lacus, dignissim eleifend enim lorem ac augue. Etiam quis venenatis ipsum. Aliquam sodales diam ac felis dignissim sollicitudin. Proin lacinia condimentum neque. Integer lacinia consequat ipsum, et consequat quam luctus venenatis. Ut tempor convallis sodales. Vivamus blandit diam non diam ornare id dignissim nunc porttitor. Phasellus rutrum, lorem sed congue pharetra, erat augue dignissim dolor, vel fermentum ipsum arcu in sapien.',
          :command => 'this is command #5', :with_params =>true, :confirm =>false)
command5.save

command6 = Command.create(:name => 'Command #6', :description => 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. In adipiscing, ligula et imperdiet malesuada, arcu quam lacinia lacus, dignissim eleifend enim lorem ac augue. Etiam quis venenatis ipsum. Aliquam sodales diam ac felis dignissim sollicitudin. Proin lacinia condimentum neque. Integer lacinia consequat ipsum, et consequat quam luctus venenatis. Ut tempor convallis sodales. Vivamus blandit diam non diam ornare id dignissim nunc porttitor. Phasellus rutrum, lorem sed congue pharetra, erat augue dignissim dolor, vel fermentum ipsum arcu in sapien.',
          :command => 'this is command #6', :with_params =>false, :confirm =>false)
command6.save


ServerCommand.create(:server => server1, :command => command1, :params => (command1.with_params ? "param #1" : "")).save
ServerCommand.create(:server => server2, :command => command2, :params => (command2.with_params ? "param #1" : "")).save
ServerCommand.create(:server => server3, :command => command3, :params => (command3.with_params ? "param #1" : "")).save
ServerCommand.create(:server => server1, :command => command4, :params => (command4.with_params ? "param #1" : "")).save
ServerCommand.create(:server => server2, :command => command5, :params => (command5.with_params ? "param #1" : "")).save
ServerCommand.create(:server => server3, :command => command6, :params => (command6.with_params ? "param #1" : "")).save
ServerCommand.create(:server => server1, :command => command2, :params => (command2.with_params ? "param #1" : "")).save
ServerCommand.create(:server => server2, :command => command3, :params => (command3.with_params ? "param #1" : "")).save
ServerCommand.create(:server => server3, :command => command4, :params => (command4.with_params ? "param #1" : "")).save
ServerCommand.create(:server => server1, :command => command5, :params => (command5.with_params ? "param #1" : "")).save
ServerCommand.create(:server => server2, :command => command6, :params => (command6.with_params ? "param #1" : "")).save
ServerCommand.create(:server => server3, :command => command1, :params => (command1.with_params ? "param #1" : "")).save


problem1 = Problem.create(:name => 'Problem #1', :description => 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. In adipiscing, ligula et imperdiet malesuada, arcu quam lacinia lacus, dignissim eleifend enim lorem ac augue. Etiam quis venenatis ipsum. Aliquam sodales diam ac felis dignissim sollicitudin. Proin lacinia condimentum neque. Integer lacinia consequat ipsum, et consequat quam luctus venenatis. Ut tempor convallis sodales. Vivamus blandit diam non diam ornare id dignissim nunc porttitor. Phasellus rutrum, lorem sed congue pharetra, erat augue dignissim dolor, vel fermentum ipsum arcu in sapien.')
problem1.save

problem2 = Problem.create(:name => 'Problem #2', :description => 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. In adipiscing, ligula et imperdiet malesuada, arcu quam lacinia lacus, dignissim eleifend enim lorem ac augue. Etiam quis venenatis ipsum. Aliquam sodales diam ac felis dignissim sollicitudin. Proin lacinia condimentum neque. Integer lacinia consequat ipsum, et consequat quam luctus venenatis. Ut tempor convallis sodales. Vivamus blandit diam non diam ornare id dignissim nunc porttitor. Phasellus rutrum, lorem sed congue pharetra, erat augue dignissim dolor, vel fermentum ipsum arcu in sapien.')
problem2.save

problem3 = Problem.create(:name => 'Problem #3', :description => 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. In adipiscing, ligula et imperdiet malesuada, arcu quam lacinia lacus, dignissim eleifend enim lorem ac augue. Etiam quis venenatis ipsum. Aliquam sodales diam ac felis dignissim sollicitudin. Proin lacinia condimentum neque. Integer lacinia consequat ipsum, et consequat quam luctus venenatis. Ut tempor convallis sodales. Vivamus blandit diam non diam ornare id dignissim nunc porttitor. Phasellus rutrum, lorem sed congue pharetra, erat augue dignissim dolor, vel fermentum ipsum arcu in sapien.')
problem3.save


ServerProblem.create(:server => server1, :problem => problem1).save
ServerProblem.create(:server => server2, :problem => problem1).save
ServerProblem.create(:server => server3, :problem => problem1).save
ServerProblem.create(:server => server1, :problem => problem2).save
ServerProblem.create(:server => server2, :problem => problem2).save
ServerProblem.create(:server => server3, :problem => problem2).save
ServerProblem.create(:server => server1, :problem => problem3).save
ServerProblem.create(:server => server2, :problem => problem3).save
ServerProblem.create(:server => server3, :problem => problem3).save


solution1 = Solution.create(:name => 'Solution #1', :description => 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. In adipiscing, ligula et imperdiet malesuada, arcu quam lacinia lacus, dignissim eleifend enim lorem ac augue. Etiam quis venenatis ipsum. Aliquam sodales diam ac felis dignissim sollicitudin. Proin lacinia condimentum neque. Integer lacinia consequat ipsum, et consequat quam luctus venenatis. Ut tempor convallis sodales. Vivamus blandit diam non diam ornare id dignissim nunc porttitor. Phasellus rutrum, lorem sed congue pharetra, erat augue dignissim dolor, vel fermentum ipsum arcu in sapien.',
                :command => command1)
solution1.save

solution2 = Solution.create(:name => 'Solution #2', :description => 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. In adipiscing, ligula et imperdiet malesuada, arcu quam lacinia lacus, dignissim eleifend enim lorem ac augue. Etiam quis venenatis ipsum. Aliquam sodales diam ac felis dignissim sollicitudin. Proin lacinia condimentum neque. Integer lacinia consequat ipsum, et consequat quam luctus venenatis. Ut tempor convallis sodales. Vivamus blandit diam non diam ornare id dignissim nunc porttitor. Phasellus rutrum, lorem sed congue pharetra, erat augue dignissim dolor, vel fermentum ipsum arcu in sapien.',
                :command => command2)
solution2.save

solution3 = Solution.create(:name => 'Solution #3', :description => 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. In adipiscing, ligula et imperdiet malesuada, arcu quam lacinia lacus, dignissim eleifend enim lorem ac augue. Etiam quis venenatis ipsum. Aliquam sodales diam ac felis dignissim sollicitudin. Proin lacinia condimentum neque. Integer lacinia consequat ipsum, et consequat quam luctus venenatis. Ut tempor convallis sodales. Vivamus blandit diam non diam ornare id dignissim nunc porttitor. Phasellus rutrum, lorem sed congue pharetra, erat augue dignissim dolor, vel fermentum ipsum arcu in sapien.',
                :command => command3)
solution3.save

solution4 = Solution.create(:name => 'Solution #4', :description => 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. In adipiscing, ligula et imperdiet malesuada, arcu quam lacinia lacus, dignissim eleifend enim lorem ac augue. Etiam quis venenatis ipsum. Aliquam sodales diam ac felis dignissim sollicitudin. Proin lacinia condimentum neque. Integer lacinia consequat ipsum, et consequat quam luctus venenatis. Ut tempor convallis sodales. Vivamus blandit diam non diam ornare id dignissim nunc porttitor. Phasellus rutrum, lorem sed congue pharetra, erat augue dignissim dolor, vel fermentum ipsum arcu in sapien.',
                :command => command4)
solution4.save

solution5 = Solution.create(:name => 'Solution #5', :description => 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. In adipiscing, ligula et imperdiet malesuada, arcu quam lacinia lacus, dignissim eleifend enim lorem ac augue. Etiam quis venenatis ipsum. Aliquam sodales diam ac felis dignissim sollicitudin. Proin lacinia condimentum neque. Integer lacinia consequat ipsum, et consequat quam luctus venenatis. Ut tempor convallis sodales. Vivamus blandit diam non diam ornare id dignissim nunc porttitor. Phasellus rutrum, lorem sed congue pharetra, erat augue dignissim dolor, vel fermentum ipsum arcu in sapien.',
                :command => command5)
solution5.save

solution6 = Solution.create(:name => 'Solution #6', :description => 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. In adipiscing, ligula et imperdiet malesuada, arcu quam lacinia lacus, dignissim eleifend enim lorem ac augue. Etiam quis venenatis ipsum. Aliquam sodales diam ac felis dignissim sollicitudin. Proin lacinia condimentum neque. Integer lacinia consequat ipsum, et consequat quam luctus venenatis. Ut tempor convallis sodales. Vivamus blandit diam non diam ornare id dignissim nunc porttitor. Phasellus rutrum, lorem sed congue pharetra, erat augue dignissim dolor, vel fermentum ipsum arcu in sapien.',
                :command => command6)
solution6.save

solution7 = Solution.create(:name => 'Solution #7', :description => 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. In adipiscing, ligula et imperdiet malesuada, arcu quam lacinia lacus, dignissim eleifend enim lorem ac augue. Etiam quis venenatis ipsum. Aliquam sodales diam ac felis dignissim sollicitudin. Proin lacinia condimentum neque. Integer lacinia consequat ipsum, et consequat quam luctus venenatis. Ut tempor convallis sodales. Vivamus blandit diam non diam ornare id dignissim nunc porttitor. Phasellus rutrum, lorem sed congue pharetra, erat augue dignissim dolor, vel fermentum ipsum arcu in sapien.',
                :command => command1)
solution7.save

solution8 = Solution.create(:name => 'Solution #8', :description => 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. In adipiscing, ligula et imperdiet malesuada, arcu quam lacinia lacus, dignissim eleifend enim lorem ac augue. Etiam quis venenatis ipsum. Aliquam sodales diam ac felis dignissim sollicitudin. Proin lacinia condimentum neque. Integer lacinia consequat ipsum, et consequat quam luctus venenatis. Ut tempor convallis sodales. Vivamus blandit diam non diam ornare id dignissim nunc porttitor. Phasellus rutrum, lorem sed congue pharetra, erat augue dignissim dolor, vel fermentum ipsum arcu in sapien.',
                :command => command3)
solution8.save

solution9 = Solution.create(:name => 'Solution #9', :description => 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. In adipiscing, ligula et imperdiet malesuada, arcu quam lacinia lacus, dignissim eleifend enim lorem ac augue. Etiam quis venenatis ipsum. Aliquam sodales diam ac felis dignissim sollicitudin. Proin lacinia condimentum neque. Integer lacinia consequat ipsum, et consequat quam luctus venenatis. Ut tempor convallis sodales. Vivamus blandit diam non diam ornare id dignissim nunc porttitor. Phasellus rutrum, lorem sed congue pharetra, erat augue dignissim dolor, vel fermentum ipsum arcu in sapien.',
                :command => command6)
solution9.save


ProblemSolution.create(:problem => problem1, :solution => solution1, :params => (solution1.command.with_params ? "param #1" : "")).save
ProblemSolution.create(:problem => problem2, :solution => solution2, :params => (solution2.command.with_params ? "param #1" : "")).save
ProblemSolution.create(:problem => problem3, :solution => solution3, :params => (solution3.command.with_params ? "param #1" : "")).save
ProblemSolution.create(:problem => problem1, :solution => solution4, :params => (solution4.command.with_params ? "param #1" : "")).save
ProblemSolution.create(:problem => problem2, :solution => solution5, :params => (solution5.command.with_params ? "param #1" : "")).save
ProblemSolution.create(:problem => problem3, :solution => solution6, :params => (solution6.command.with_params ? "param #1" : "")).save
ProblemSolution.create(:problem => problem1, :solution => solution7, :params => (solution7.command.with_params ? "param #1" : "")).save
ProblemSolution.create(:problem => problem2, :solution => solution8, :params => (solution8.command.with_params ? "param #1" : "")).save
ProblemSolution.create(:problem => problem3, :solution => solution9, :params => (solution9.command.with_params ? "param #1" : "")).save
