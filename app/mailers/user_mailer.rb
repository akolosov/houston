class UserMailer < ActionMailer::Base
  include ApplicationHelper

  default from: Houston::Application.config.email

  def user_created(user)
    @user = user

    mail(to: user.email, subject: "Учетная запись создана")

    if (user.jabber)
      send_jabber_message(user.jabber, "Учетная запись создана", (render 'user_mailer/user_created', locals: { user: user }, formats: [:text]))
    end
  end

  def user_reseted(user)
    @user = user

    mail(to: user.email, subject: "Настройки учетной записи сброшены")

    if (user.jabber)
      send_jabber_message(user.jabber, "Настройки учетной записи сброшены", (render 'user_mailer/user_reseted', locals: { user: user }, formats: [:text]))
    end
  end

  def user_deleted(user)
    @user = user

    mail(to: user.email, subject: "Учетная запись удалена")

    if (user.jabber)
      send_jabber_message(user.jabber, "Учетная запись удалена", (render 'user_mailer/user_deleted', locals: { user: user }, formats: [:text]))
    end
  end

  def user_activated(user)
    @user = user

    mail(to: user.email, subject: "Учетная запись активирована")

    if (user.jabber)
      send_jabber_message(user.jabber, "Учетная запись активирована", (render 'user_mailer/user_activated', locals: { user: user }, formats: [:text]))
    end
  end

  def user_deactivated(user)
    @user = user

    mail(to: user.email, subject: "Учетная запись даактивирована")

    if (user.jabber)
      send_jabber_message(user.jabber, "Учетная запись деактивирована", (render 'user_mailer/user_deactivated', locals: { user: user }, formats: [:text]))
    end
  end

end
