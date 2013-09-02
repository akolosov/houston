Houston
=======

Центр управления полётами. Центр решения проблем. База знаний. Книга жалоб и предложений. Упрощенный вариант.

# Настройка (Development)
    git clone git://github.com/akolosov/houston.git
    cd houston
    bundle install
    rake db:migrate
    rake db:seed

# Использование (Development)
    rails s
    open http://0.0.0.0:3000/
    
# Вход в систему (Development)
    E-Mail: admin@test.com, Username: admin, Password: admin
    E-Mail: manager@test.com, Username: manager, Password: manager
    E-Mail: client@test.com, Username: client, Password: client
    E-Mail: operator@test.com, Username: operator, Password: operator
    E-Mail: executor@test.com, Username: executor, Password: executor

# License

(C)opyLeft & (C)odeRight Alexey Kolosov aka mr.huNTer <alexey.kolosov@gmail.com>

"Houston" released without warranty under the terms of the Artistic License 2.0
http://www.opensource.org/licenses/artistic-license-2.0


