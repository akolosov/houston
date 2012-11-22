# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)

Role.create([ { :name => 'admin' }, { :name => 'manager' } ], :without_protection => true)

if Rails.env.production?
  admin = User.create :username => 'hunter', :email => 'alexey.kolosov@gmail.com', :password => 'admin', :password_confirmation => 'admin'
  admin.save
  admin.add_role :admin
else
  admin = User.create :username => 'admin', :email => 'admin@test.com', :password => 'admin', :password_confirmation => 'admin'
  admin.save
  admin.add_role :admin

  user = User.create :username => 'manager', :email => 'manager@test.com', :password => 'manager', :password_confirmation => 'manager'
  user.save
  user.add_role :manager

  Auditor::User.current_user = admin

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
            :command => '/this/is/command/1', :confirm =>false)
  command1.save

  command2 = Command.create(:name => 'Command #2', :description => 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. In adipiscing, ligula et imperdiet malesuada, arcu quam lacinia lacus, dignissim eleifend enim lorem ac augue. Etiam quis venenatis ipsum. Aliquam sodales diam ac felis dignissim sollicitudin. Proin lacinia condimentum neque. Integer lacinia consequat ipsum, et consequat quam luctus venenatis. Ut tempor convallis sodales. Vivamus blandit diam non diam ornare id dignissim nunc porttitor. Phasellus rutrum, lorem sed congue pharetra, erat augue dignissim dolor, vel fermentum ipsum arcu in sapien.',
            :command => '/this/is/command/2', :confirm =>true)
  command2.save

  command3 = Command.create(:name => 'Command #3', :description => 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. In adipiscing, ligula et imperdiet malesuada, arcu quam lacinia lacus, dignissim eleifend enim lorem ac augue. Etiam quis venenatis ipsum. Aliquam sodales diam ac felis dignissim sollicitudin. Proin lacinia condimentum neque. Integer lacinia consequat ipsum, et consequat quam luctus venenatis. Ut tempor convallis sodales. Vivamus blandit diam non diam ornare id dignissim nunc porttitor. Phasellus rutrum, lorem sed congue pharetra, erat augue dignissim dolor, vel fermentum ipsum arcu in sapien.',
            :command => '/this/is/command/3', :confirm =>false)
  command3.save

  command4 = Command.create(:name => 'Command #4', :description => 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. In adipiscing, ligula et imperdiet malesuada, arcu quam lacinia lacus, dignissim eleifend enim lorem ac augue. Etiam quis venenatis ipsum. Aliquam sodales diam ac felis dignissim sollicitudin. Proin lacinia condimentum neque. Integer lacinia consequat ipsum, et consequat quam luctus venenatis. Ut tempor convallis sodales. Vivamus blandit diam non diam ornare id dignissim nunc porttitor. Phasellus rutrum, lorem sed congue pharetra, erat augue dignissim dolor, vel fermentum ipsum arcu in sapien.',
            :command => '/this/is/command/4', :confirm =>true)
  command4.save

  command5 = Command.create(:name => 'Command #5', :description => 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. In adipiscing, ligula et imperdiet malesuada, arcu quam lacinia lacus, dignissim eleifend enim lorem ac augue. Etiam quis venenatis ipsum. Aliquam sodales diam ac felis dignissim sollicitudin. Proin lacinia condimentum neque. Integer lacinia consequat ipsum, et consequat quam luctus venenatis. Ut tempor convallis sodales. Vivamus blandit diam non diam ornare id dignissim nunc porttitor. Phasellus rutrum, lorem sed congue pharetra, erat augue dignissim dolor, vel fermentum ipsum arcu in sapien.',
            :command => '/this/is/command/5', :confirm =>false)
  command5.save

  command6 = Command.create(:name => 'Command #6', :description => 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. In adipiscing, ligula et imperdiet malesuada, arcu quam lacinia lacus, dignissim eleifend enim lorem ac augue. Etiam quis venenatis ipsum. Aliquam sodales diam ac felis dignissim sollicitudin. Proin lacinia condimentum neque. Integer lacinia consequat ipsum, et consequat quam luctus venenatis. Ut tempor convallis sodales. Vivamus blandit diam non diam ornare id dignissim nunc porttitor. Phasellus rutrum, lorem sed congue pharetra, erat augue dignissim dolor, vel fermentum ipsum arcu in sapien.',
            :command => '/this/is/command/6', :confirm =>false)
  command6.save


  ServerCommand.create(:server => server1, :command => command1, :params => "this_is_param_for_command1").save
  ServerCommand.create(:server => server2, :command => command2, :params => "this_is_param_for_command2").save
  ServerCommand.create(:server => server3, :command => command3, :params => "this_is_param_for_command3").save
  ServerCommand.create(:server => server1, :command => command4, :params => "this_is_param_for_command4").save
  ServerCommand.create(:server => server2, :command => command5, :params => "this_is_param_for_command5").save
  ServerCommand.create(:server => server3, :command => command6, :params => "this_is_param_for_command6").save
  ServerCommand.create(:server => server1, :command => command2, :params => "this_is_param_for_command2").save
  ServerCommand.create(:server => server2, :command => command3, :params => "this_is_param_for_command3").save
  ServerCommand.create(:server => server3, :command => command4, :params => "this_is_param_for_command4").save
  ServerCommand.create(:server => server1, :command => command5, :params => "this_is_param_for_command5").save
  ServerCommand.create(:server => server2, :command => command6, :params => "this_is_param_for_command6").save
  ServerCommand.create(:server => server3, :command => command1, :params => "this_is_param_for_command1").save


  problem1 = Problem.create(:name => 'Problem #1', :description => 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. In adipiscing, ligula et imperdiet malesuada, arcu quam lacinia lacus, dignissim eleifend enim lorem ac augue. Etiam quis venenatis ipsum. Aliquam sodales diam ac felis dignissim sollicitudin. Proin lacinia condimentum neque. Integer lacinia consequat ipsum, et consequat quam luctus venenatis. Ut tempor convallis sodales. Vivamus blandit diam non diam ornare id dignissim nunc porttitor. Phasellus rutrum, lorem sed congue pharetra, erat augue dignissim dolor, vel fermentum ipsum arcu in sapien.')
  problem1.save

  problem2 = Problem.create(:name => 'Problem #2', :description => 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. In adipiscing, ligula et imperdiet malesuada, arcu quam lacinia lacus, dignissim eleifend enim lorem ac augue. Etiam quis venenatis ipsum. Aliquam sodales diam ac felis dignissim sollicitudin. Proin lacinia condimentum neque. Integer lacinia consequat ipsum, et consequat quam luctus venenatis. Ut tempor convallis sodales. Vivamus blandit diam non diam ornare id dignissim nunc porttitor. Phasellus rutrum, lorem sed congue pharetra, erat augue dignissim dolor, vel fermentum ipsum arcu in sapien.')
  problem2.save

  problem3 = Problem.create(:name => 'Problem #3', :description => 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. In adipiscing, ligula et imperdiet malesuada, arcu quam lacinia lacus, dignissim eleifend enim lorem ac augue. Etiam quis venenatis ipsum. Aliquam sodales diam ac felis dignissim sollicitudin. Proin lacinia condimentum neque. Integer lacinia consequat ipsum, et consequat quam luctus venenatis. Ut tempor convallis sodales. Vivamus blandit diam non diam ornare id dignissim nunc porttitor. Phasellus rutrum, lorem sed congue pharetra, erat augue dignissim dolor, vel fermentum ipsum arcu in sapien.')
  problem3.save


  ServerProblem.create(:server => server1, :problem => problem1).save
  ServerProblem.create(:server => server3, :problem => problem1).save
  ServerProblem.create(:server => server2, :problem => problem2).save
  ServerProblem.create(:server => server3, :problem => problem2).save
  ServerProblem.create(:server => server1, :problem => problem3).save
  ServerProblem.create(:server => server2, :problem => problem3).save


  Solution.create(:name => 'Solution #1', :description => 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. In adipiscing, ligula et imperdiet malesuada, arcu quam lacinia lacus, dignissim eleifend enim lorem ac augue. Etiam quis venenatis ipsum. Aliquam sodales diam ac felis dignissim sollicitudin. Proin lacinia condimentum neque. Integer lacinia consequat ipsum, et consequat quam luctus venenatis. Ut tempor convallis sodales. Vivamus blandit diam non diam ornare id dignissim nunc porttitor. Phasellus rutrum, lorem sed congue pharetra, erat augue dignissim dolor, vel fermentum ipsum arcu in sapien.',
                  :command => command1).save
  Solution.create(:name => 'Solution #2', :description => 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. In adipiscing, ligula et imperdiet malesuada, arcu quam lacinia lacus, dignissim eleifend enim lorem ac augue. Etiam quis venenatis ipsum. Aliquam sodales diam ac felis dignissim sollicitudin. Proin lacinia condimentum neque. Integer lacinia consequat ipsum, et consequat quam luctus venenatis. Ut tempor convallis sodales. Vivamus blandit diam non diam ornare id dignissim nunc porttitor. Phasellus rutrum, lorem sed congue pharetra, erat augue dignissim dolor, vel fermentum ipsum arcu in sapien.',
                  :command => command2).save
  Solution.create(:name => 'Solution #3', :description => 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. In adipiscing, ligula et imperdiet malesuada, arcu quam lacinia lacus, dignissim eleifend enim lorem ac augue. Etiam quis venenatis ipsum. Aliquam sodales diam ac felis dignissim sollicitudin. Proin lacinia condimentum neque. Integer lacinia consequat ipsum, et consequat quam luctus venenatis. Ut tempor convallis sodales. Vivamus blandit diam non diam ornare id dignissim nunc porttitor. Phasellus rutrum, lorem sed congue pharetra, erat augue dignissim dolor, vel fermentum ipsum arcu in sapien.',
                  :command => command3).save
  Solution.create(:name => 'Solution #4', :description => 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. In adipiscing, ligula et imperdiet malesuada, arcu quam lacinia lacus, dignissim eleifend enim lorem ac augue. Etiam quis venenatis ipsum. Aliquam sodales diam ac felis dignissim sollicitudin. Proin lacinia condimentum neque. Integer lacinia consequat ipsum, et consequat quam luctus venenatis. Ut tempor convallis sodales. Vivamus blandit diam non diam ornare id dignissim nunc porttitor. Phasellus rutrum, lorem sed congue pharetra, erat augue dignissim dolor, vel fermentum ipsum arcu in sapien.',
                  :command => command4).save
  Solution.create(:name => 'Solution #5', :description => 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. In adipiscing, ligula et imperdiet malesuada, arcu quam lacinia lacus, dignissim eleifend enim lorem ac augue. Etiam quis venenatis ipsum. Aliquam sodales diam ac felis dignissim sollicitudin. Proin lacinia condimentum neque. Integer lacinia consequat ipsum, et consequat quam luctus venenatis. Ut tempor convallis sodales. Vivamus blandit diam non diam ornare id dignissim nunc porttitor. Phasellus rutrum, lorem sed congue pharetra, erat augue dignissim dolor, vel fermentum ipsum arcu in sapien.',
                  :command => command5).save
  Solution.create(:name => 'Solution #6', :description => 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. In adipiscing, ligula et imperdiet malesuada, arcu quam lacinia lacus, dignissim eleifend enim lorem ac augue. Etiam quis venenatis ipsum. Aliquam sodales diam ac felis dignissim sollicitudin. Proin lacinia condimentum neque. Integer lacinia consequat ipsum, et consequat quam luctus venenatis. Ut tempor convallis sodales. Vivamus blandit diam non diam ornare id dignissim nunc porttitor. Phasellus rutrum, lorem sed congue pharetra, erat augue dignissim dolor, vel fermentum ipsum arcu in sapien.',
                  :command => command6).save
  Solution.create(:name => 'Solution #7', :description => 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. In adipiscing, ligula et imperdiet malesuada, arcu quam lacinia lacus, dignissim eleifend enim lorem ac augue. Etiam quis venenatis ipsum. Aliquam sodales diam ac felis dignissim sollicitudin. Proin lacinia condimentum neque. Integer lacinia consequat ipsum, et consequat quam luctus venenatis. Ut tempor convallis sodales. Vivamus blandit diam non diam ornare id dignissim nunc porttitor. Phasellus rutrum, lorem sed congue pharetra, erat augue dignissim dolor, vel fermentum ipsum arcu in sapien.',
                  :command => command1).save
  Solution.create(:name => 'Solution #8', :description => 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. In adipiscing, ligula et imperdiet malesuada, arcu quam lacinia lacus, dignissim eleifend enim lorem ac augue. Etiam quis venenatis ipsum. Aliquam sodales diam ac felis dignissim sollicitudin. Proin lacinia condimentum neque. Integer lacinia consequat ipsum, et consequat quam luctus venenatis. Ut tempor convallis sodales. Vivamus blandit diam non diam ornare id dignissim nunc porttitor. Phasellus rutrum, lorem sed congue pharetra, erat augue dignissim dolor, vel fermentum ipsum arcu in sapien.',
                  :command => command3).save
  Solution.create(:name => 'Solution #9', :description => 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. In adipiscing, ligula et imperdiet malesuada, arcu quam lacinia lacus, dignissim eleifend enim lorem ac augue. Etiam quis venenatis ipsum. Aliquam sodales diam ac felis dignissim sollicitudin. Proin lacinia condimentum neque. Integer lacinia consequat ipsum, et consequat quam luctus venenatis. Ut tempor convallis sodales. Vivamus blandit diam non diam ornare id dignissim nunc porttitor. Phasellus rutrum, lorem sed congue pharetra, erat augue dignissim dolor, vel fermentum ipsum arcu in sapien.',
                  :command => command6).save


  ProblemSolution.create(:problem => problem1, :solution => Solution.solution_with_command(command1)).save
  ProblemSolution.create(:problem => problem2, :solution => Solution.solution_with_command(command2)).save
  ProblemSolution.create(:problem => problem3, :solution => Solution.solution_with_command(command3)).save
  ProblemSolution.create(:problem => problem1, :solution => Solution.solution_with_command(command4)).save
  ProblemSolution.create(:problem => problem2, :solution => Solution.solution_with_command(command5)).save
  ProblemSolution.create(:problem => problem3, :solution => Solution.solution_with_command(command6)).save
  ProblemSolution.create(:problem => problem1, :solution => Solution.solution_with_command(command2)).save
  ProblemSolution.create(:problem => problem2, :solution => Solution.solution_with_command(command3)).save
  ProblemSolution.create(:problem => problem3, :solution => Solution.solution_with_command(command4)).save
end
