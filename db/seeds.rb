# encoding: utf-8
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)

Role.create([ { :name => 'admin' }, { :name => 'manager' } ], :without_protection => true)

if Rails.env.production?
  admin = User.create :username => 'hunter', :email => 'alexey.kolosov@gmail.com', :password => 'admin', :password_confirmation => 'admin', :realname => 'Алексей Колосов'
  admin.save
  admin.add_role :admin
else
  admin = User.create :username => 'admin', :email => 'admin@test.com', :password => 'admin', :password_confirmation => 'admin', :realname => 'Admin Admin'
  admin.save
  admin.add_role :admin

  user = User.create :username => 'manager', :email => 'manager@test.com', :password => 'manager', :password_confirmation => 'manager', :realname => 'Manager Manager'
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

  tag1 = Tag.create(:name => "tag #1")
  tag1.save

  tag2 = Tag.create(:name => "tag #2")
  tag2.save
  
  tag3 = Tag.create(:name => "tag #3")
  tag3.save
  
  tag4 = Tag.create(:name => "tag #4")
  tag4.save
  
  tag5 = Tag.create(:name => "tag #5")
  tag5.save
 
  problem1 = Problem.create(:name => 'Problem #1', :description => 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. In adipiscing, ligula et imperdiet malesuada, arcu quam lacinia lacus, dignissim eleifend enim lorem ac augue. Etiam quis venenatis ipsum. Aliquam sodales diam ac felis dignissim sollicitudin. Proin lacinia condimentum neque. Integer lacinia consequat ipsum, et consequat quam luctus venenatis. Ut tempor convallis sodales. Vivamus blandit diam non diam ornare id dignissim nunc porttitor. Phasellus rutrum, lorem sed congue pharetra, erat augue dignissim dolor, vel fermentum ipsum arcu in sapien.', :tags => [tag1, tag3])
  problem1.save

  problem2 = Problem.create(:name => 'Problem #2', :description => 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. In adipiscing, ligula et imperdiet malesuada, arcu quam lacinia lacus, dignissim eleifend enim lorem ac augue. Etiam quis venenatis ipsum. Aliquam sodales diam ac felis dignissim sollicitudin. Proin lacinia condimentum neque. Integer lacinia consequat ipsum, et consequat quam luctus venenatis. Ut tempor convallis sodales. Vivamus blandit diam non diam ornare id dignissim nunc porttitor. Phasellus rutrum, lorem sed congue pharetra, erat augue dignissim dolor, vel fermentum ipsum arcu in sapien.', :tags => [tag2, tag5])
  problem2.save

  problem3 = Problem.create(:name => 'Problem #3', :description => 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. In adipiscing, ligula et imperdiet malesuada, arcu quam lacinia lacus, dignissim eleifend enim lorem ac augue. Etiam quis venenatis ipsum. Aliquam sodales diam ac felis dignissim sollicitudin. Proin lacinia condimentum neque. Integer lacinia consequat ipsum, et consequat quam luctus venenatis. Ut tempor convallis sodales. Vivamus blandit diam non diam ornare id dignissim nunc porttitor. Phasellus rutrum, lorem sed congue pharetra, erat augue dignissim dolor, vel fermentum ipsum arcu in sapien.', :tags => [tag3, tag5])
  problem3.save


  ServerProblem.create(:server => server1, :problem => problem1).save
  ServerProblem.create(:server => server3, :problem => problem1).save
  ServerProblem.create(:server => server2, :problem => problem2).save
  ServerProblem.create(:server => server3, :problem => problem2).save
  ServerProblem.create(:server => server1, :problem => problem3).save
  ServerProblem.create(:server => server2, :problem => problem3).save


  Solution.create(:name => 'Solution #1', :description => 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. In adipiscing, ligula et imperdiet malesuada, arcu quam lacinia lacus, dignissim eleifend enim lorem ac augue. Etiam quis venenatis ipsum. Aliquam sodales diam ac felis dignissim sollicitudin. Proin lacinia condimentum neque. Integer lacinia consequat ipsum, et consequat quam luctus venenatis. Ut tempor convallis sodales. Vivamus blandit diam non diam ornare id dignissim nunc porttitor. Phasellus rutrum, lorem sed congue pharetra, erat augue dignissim dolor, vel fermentum ipsum arcu in sapien.').save
  Solution.create(:name => 'Solution #2', :description => 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. In adipiscing, ligula et imperdiet malesuada, arcu quam lacinia lacus, dignissim eleifend enim lorem ac augue. Etiam quis venenatis ipsum. Aliquam sodales diam ac felis dignissim sollicitudin. Proin lacinia condimentum neque. Integer lacinia consequat ipsum, et consequat quam luctus venenatis. Ut tempor convallis sodales. Vivamus blandit diam non diam ornare id dignissim nunc porttitor. Phasellus rutrum, lorem sed congue pharetra, erat augue dignissim dolor, vel fermentum ipsum arcu in sapien.').save
  Solution.create(:name => 'Solution #3', :description => 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. In adipiscing, ligula et imperdiet malesuada, arcu quam lacinia lacus, dignissim eleifend enim lorem ac augue. Etiam quis venenatis ipsum. Aliquam sodales diam ac felis dignissim sollicitudin. Proin lacinia condimentum neque. Integer lacinia consequat ipsum, et consequat quam luctus venenatis. Ut tempor convallis sodales. Vivamus blandit diam non diam ornare id dignissim nunc porttitor. Phasellus rutrum, lorem sed congue pharetra, erat augue dignissim dolor, vel fermentum ipsum arcu in sapien.').save
  Solution.create(:name => 'Solution #4', :description => 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. In adipiscing, ligula et imperdiet malesuada, arcu quam lacinia lacus, dignissim eleifend enim lorem ac augue. Etiam quis venenatis ipsum. Aliquam sodales diam ac felis dignissim sollicitudin. Proin lacinia condimentum neque. Integer lacinia consequat ipsum, et consequat quam luctus venenatis. Ut tempor convallis sodales. Vivamus blandit diam non diam ornare id dignissim nunc porttitor. Phasellus rutrum, lorem sed congue pharetra, erat augue dignissim dolor, vel fermentum ipsum arcu in sapien.').save
  Solution.create(:name => 'Solution #5', :description => 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. In adipiscing, ligula et imperdiet malesuada, arcu quam lacinia lacus, dignissim eleifend enim lorem ac augue. Etiam quis venenatis ipsum. Aliquam sodales diam ac felis dignissim sollicitudin. Proin lacinia condimentum neque. Integer lacinia consequat ipsum, et consequat quam luctus venenatis. Ut tempor convallis sodales. Vivamus blandit diam non diam ornare id dignissim nunc porttitor. Phasellus rutrum, lorem sed congue pharetra, erat augue dignissim dolor, vel fermentum ipsum arcu in sapien.').save
  Solution.create(:name => 'Solution #6', :description => 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. In adipiscing, ligula et imperdiet malesuada, arcu quam lacinia lacus, dignissim eleifend enim lorem ac augue. Etiam quis venenatis ipsum. Aliquam sodales diam ac felis dignissim sollicitudin. Proin lacinia condimentum neque. Integer lacinia consequat ipsum, et consequat quam luctus venenatis. Ut tempor convallis sodales. Vivamus blandit diam non diam ornare id dignissim nunc porttitor. Phasellus rutrum, lorem sed congue pharetra, erat augue dignissim dolor, vel fermentum ipsum arcu in sapien.').save
  Solution.create(:name => 'Solution #7', :description => 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. In adipiscing, ligula et imperdiet malesuada, arcu quam lacinia lacus, dignissim eleifend enim lorem ac augue. Etiam quis venenatis ipsum. Aliquam sodales diam ac felis dignissim sollicitudin. Proin lacinia condimentum neque. Integer lacinia consequat ipsum, et consequat quam luctus venenatis. Ut tempor convallis sodales. Vivamus blandit diam non diam ornare id dignissim nunc porttitor. Phasellus rutrum, lorem sed congue pharetra, erat augue dignissim dolor, vel fermentum ipsum arcu in sapien.').save
  Solution.create(:name => 'Solution #8', :description => 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. In adipiscing, ligula et imperdiet malesuada, arcu quam lacinia lacus, dignissim eleifend enim lorem ac augue. Etiam quis venenatis ipsum. Aliquam sodales diam ac felis dignissim sollicitudin. Proin lacinia condimentum neque. Integer lacinia consequat ipsum, et consequat quam luctus venenatis. Ut tempor convallis sodales. Vivamus blandit diam non diam ornare id dignissim nunc porttitor. Phasellus rutrum, lorem sed congue pharetra, erat augue dignissim dolor, vel fermentum ipsum arcu in sapien.').save
  Solution.create(:name => 'Solution #9', :description => 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. In adipiscing, ligula et imperdiet malesuada, arcu quam lacinia lacus, dignissim eleifend enim lorem ac augue. Etiam quis venenatis ipsum. Aliquam sodales diam ac felis dignissim sollicitudin. Proin lacinia condimentum neque. Integer lacinia consequat ipsum, et consequat quam luctus venenatis. Ut tempor convallis sodales. Vivamus blandit diam non diam ornare id dignissim nunc porttitor. Phasellus rutrum, lorem sed congue pharetra, erat augue dignissim dolor, vel fermentum ipsum arcu in sapien.').save


  ProblemSolution.create(:problem => problem1, :solution => Solution.find(Random.rand(9)+1)).save
  ProblemSolution.create(:problem => problem2, :solution => Solution.find(Random.rand(9)+1)).save
  ProblemSolution.create(:problem => problem3, :solution => Solution.find(Random.rand(9)+1)).save
  ProblemSolution.create(:problem => problem1, :solution => Solution.find(Random.rand(9)+1)).save
  ProblemSolution.create(:problem => problem2, :solution => Solution.find(Random.rand(9)+1)).save
  ProblemSolution.create(:problem => problem3, :solution => Solution.find(Random.rand(9)+1)).save
  ProblemSolution.create(:problem => problem1, :solution => Solution.find(Random.rand(9)+1)).save
  ProblemSolution.create(:problem => problem2, :solution => Solution.find(Random.rand(9)+1)).save
  ProblemSolution.create(:problem => problem3, :solution => Solution.find(Random.rand(9)+1)).save


  Document.create(:title => 'Document #1', :body => 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. In adipiscing, ligula et imperdiet malesuada, arcu quam lacinia lacus, dignissim eleifend enim lorem ac augue. Etiam quis venenatis ipsum. Aliquam sodales diam ac felis dignissim sollicitudin. Proin lacinia condimentum neque. Integer lacinia consequat ipsum, et consequat quam luctus venenatis. Ut tempor convallis sodales. Vivamus blandit diam non diam ornare id dignissim nunc porttitor. Phasellus rutrum, lorem sed congue pharetra, erat augue dignissim dolor, vel fermentum ipsum arcu in sapien.', :user => admin).save
  Document.create(:title => 'Document #2', :body => 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. In adipiscing, ligula et imperdiet malesuada, arcu quam lacinia lacus, dignissim eleifend enim lorem ac augue. Etiam quis venenatis ipsum. Aliquam sodales diam ac felis dignissim sollicitudin. Proin lacinia condimentum neque. Integer lacinia consequat ipsum, et consequat quam luctus venenatis. Ut tempor convallis sodales. Vivamus blandit diam non diam ornare id dignissim nunc porttitor. Phasellus rutrum, lorem sed congue pharetra, erat augue dignissim dolor, vel fermentum ipsum arcu in sapien.', :user => admin).save
  Document.create(:title => 'Document #3', :body => 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. In adipiscing, ligula et imperdiet malesuada, arcu quam lacinia lacus, dignissim eleifend enim lorem ac augue. Etiam quis venenatis ipsum. Aliquam sodales diam ac felis dignissim sollicitudin. Proin lacinia condimentum neque. Integer lacinia consequat ipsum, et consequat quam luctus venenatis. Ut tempor convallis sodales. Vivamus blandit diam non diam ornare id dignissim nunc porttitor. Phasellus rutrum, lorem sed congue pharetra, erat augue dignissim dolor, vel fermentum ipsum arcu in sapien.', :user => user).save
  Document.create(:title => 'Document #4', :body => 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. In adipiscing, ligula et imperdiet malesuada, arcu quam lacinia lacus, dignissim eleifend enim lorem ac augue. Etiam quis venenatis ipsum. Aliquam sodales diam ac felis dignissim sollicitudin. Proin lacinia condimentum neque. Integer lacinia consequat ipsum, et consequat quam luctus venenatis. Ut tempor convallis sodales. Vivamus blandit diam non diam ornare id dignissim nunc porttitor. Phasellus rutrum, lorem sed congue pharetra, erat augue dignissim dolor, vel fermentum ipsum arcu in sapien.', :user => user).save
  Document.create(:title => 'Document #5', :body => 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. In adipiscing, ligula et imperdiet malesuada, arcu quam lacinia lacus, dignissim eleifend enim lorem ac augue. Etiam quis venenatis ipsum. Aliquam sodales diam ac felis dignissim sollicitudin. Proin lacinia condimentum neque. Integer lacinia consequat ipsum, et consequat quam luctus venenatis. Ut tempor convallis sodales. Vivamus blandit diam non diam ornare id dignissim nunc porttitor. Phasellus rutrum, lorem sed congue pharetra, erat augue dignissim dolor, vel fermentum ipsum arcu in sapien.', :user => admin).save
  Document.create(:title => 'Document #6', :body => 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. In adipiscing, ligula et imperdiet malesuada, arcu quam lacinia lacus, dignissim eleifend enim lorem ac augue. Etiam quis venenatis ipsum. Aliquam sodales diam ac felis dignissim sollicitudin. Proin lacinia condimentum neque. Integer lacinia consequat ipsum, et consequat quam luctus venenatis. Ut tempor convallis sodales. Vivamus blandit diam non diam ornare id dignissim nunc porttitor. Phasellus rutrum, lorem sed congue pharetra, erat augue dignissim dolor, vel fermentum ipsum arcu in sapien.', :user => user).save
  Document.create(:title => 'Document #7', :body => 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. In adipiscing, ligula et imperdiet malesuada, arcu quam lacinia lacus, dignissim eleifend enim lorem ac augue. Etiam quis venenatis ipsum. Aliquam sodales diam ac felis dignissim sollicitudin. Proin lacinia condimentum neque. Integer lacinia consequat ipsum, et consequat quam luctus venenatis. Ut tempor convallis sodales. Vivamus blandit diam non diam ornare id dignissim nunc porttitor. Phasellus rutrum, lorem sed congue pharetra, erat augue dignissim dolor, vel fermentum ipsum arcu in sapien.', :user => user).save
  Document.create(:title => 'Document #8', :body => 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. In adipiscing, ligula et imperdiet malesuada, arcu quam lacinia lacus, dignissim eleifend enim lorem ac augue. Etiam quis venenatis ipsum. Aliquam sodales diam ac felis dignissim sollicitudin. Proin lacinia condimentum neque. Integer lacinia consequat ipsum, et consequat quam luctus venenatis. Ut tempor convallis sodales. Vivamus blandit diam non diam ornare id dignissim nunc porttitor. Phasellus rutrum, lorem sed congue pharetra, erat augue dignissim dolor, vel fermentum ipsum arcu in sapien.', :user => admin).save
  Document.create(:title => 'Document #9', :body => 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. In adipiscing, ligula et imperdiet malesuada, arcu quam lacinia lacus, dignissim eleifend enim lorem ac augue. Etiam quis venenatis ipsum. Aliquam sodales diam ac felis dignissim sollicitudin. Proin lacinia condimentum neque. Integer lacinia consequat ipsum, et consequat quam luctus venenatis. Ut tempor convallis sodales. Vivamus blandit diam non diam ornare id dignissim nunc porttitor. Phasellus rutrum, lorem sed congue pharetra, erat augue dignissim dolor, vel fermentum ipsum arcu in sapien.', :user => user).save
end
