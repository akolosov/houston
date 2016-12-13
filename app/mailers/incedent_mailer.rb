# encoding: utf-8
class IncedentMailer < ActionMailer::Base
  include ApplicationHelper

  default from: Houston::Application.config.email

  def incedent_created(incedent)
    @incedent = incedent

    @emails = (User.users_by_role_id(1).all.present? ? incedent.initiator.email : User.users_by_role_id(1).collect(&:email).join(", ")+", "+incedent.initiator.email )+(incedent.has_observers? ? ', '+incedent.observers.all.collect(&:email).join(", ") : '')

    mail(to: @emails, subject: "Жалоба №#{incedent.id} создана")

    if (@incedent.initiator.jabber)
      send_jabber_message(@incedent.initiator.jabber, "Жалоба №#{incedent.id} создана", (render 'incedent_mailer/incedent_created', locals: { incedent: @incedent }, formats: [:text]))
    end

    if (@incedent.has_worker?)
      send_jabber_message(@incedent.workers, "Жалоба №#{incedent.id} создана", (render 'incedent_mailer/incedent_created', locals: { incedent: @incedent }, formats: [:text]))
    end

    if (@incedent.has_observer?)
      send_jabber_message(@incedent.observers, "Жалоба №#{incedent.id} создана", (render 'incedent_mailer/incedent_created', locals: { incedent: @incedent }, formats: [:text]))
    end
  end

  def incedent_changed(incedent)
    @incedent = incedent

    mail(to: (incedent.has_workers? ? incedent.workers.all.collect(&:email).join(", ") : incedent.initiator.email)+(incedent.has_observers? ? ', '+incedent.observers.all.collect(&:email).join(", ") : ''), subject: "Жалоба №#{incedent.id} изменена")

    if (@incedent.has_workers?)
      send_jabber_message(@incedent.workers, "Жалоба №#{incedent.id} изменена", (render 'incedent_mailer/incedent_changed', locals: { incedent: @incedent }, formats: [:text]))
    end

    if (@incedent.has_observer?)
      send_jabber_message(@incedent.observers, "Жалоба №#{incedent.id} изменена", (render 'incedent_mailer/incedent_changed', locals: { incedent: @incedent }, formats: [:text]))
    end
  end

  def incedent_commented(incedent_comment)
    @incedent_comment = incedent_comment

    mail(to: (incedent_comment.incedent.initiator == incedent_comment.comment.author ? (incedent_comment.incedent.has_workers? ? incedent_comment.incedent.workers.all.collect(&:email).join(", ") : incedent_comment.incedent.initiator.email) : incedent_comment.incedent.initiator.email)+(incedent_comment.incedent.has_observers? ? ', '+incedent_comment.incedent.observers.all.collect(&:email).join(", ") : ''), subject: "Жалоба №#{incedent_comment.incedent.id} прокомментирована")

    if (@incedent_comment.incedent.initiator.jabber)
      send_jabber_message(@incedent_comment.incedent.initiator.jabber, "Жалоба №#{incedent_comment.incedent.id} прокомментирована", (render 'incedent_mailer/incedent_commented', locals: { incedent_comment: @incedent_comment }, formats: [:text]))
    end

    if (@incedent_comment.incedent.has_workers?)
      send_jabber_message(@incedent_comment.incedent.workers, "Жалоба №#{incedent_comment.incedent.id} прокомментирована", (render 'incedent_mailer/incedent_commented', locals: { incedent_comment: @incedent_comment }, formats: [:text]))
    end

    if (@incedent_comment.incedent.has_observers?)
      send_jabber_message(@incedent_comment.incedent.observers, "Жалоба №#{incedent_comment.incedent.id} прокомментирована", (render 'incedent_mailer/incedent_commented', locals: { incedent_comment: @incedent_comment }, formats: [:text]))
    end
  end

  def incedent_played(incedent)
    @incedent = incedent

    mail(to: incedent.initiator.email+(incedent.has_observers? ? ', '+incedent.observers.all.collect(&:email).join(", ") : ''), subject: "Жалоба №#{incedent.id} принята в работу")

    if (@incedent.initiator.jabber)
      send_jabber_message(@incedent.initiator.jabber, "Жалоба №#{incedent.id} принята в работу", (render 'incedent_mailer/incedent_played', locals: { incedent: @incedent }, formats: [:text]))
    end

    if (@incedent.has_observers?)
      send_jabber_message(@incedent.observers, "Жалоба №#{incedent.id} принята в работу", (render 'incedent_mailer/incedent_played', locals: { incedent: @incedent }, formats: [:text]))
    end
  end

  def incedent_paused(incedent)
    @incedent = incedent

    mail(to: incedent.initiator.email+(incedent.has_observers? ? ', '+incedent.observers.all.collect(&:email).join(", ") : ''), subject: "Жалоба №#{incedent.id} приостановлена")

    if (@incedent.initiator.jabber)
      send_jabber_message(@incedent.initiator.jabber, "Жалоба №#{incedent.id} приостановлена", (render 'incedent_mailer/incedent_paused', locals: { incedent: @incedent }, formats: [:text]))
    end

    if (@incedent.has_observers?)
      send_jabber_message(@incedent.observers, "Жалоба №#{incedent.id} приостановлена", (render 'incedent_mailer/incedent_paused', locals: { incedent: @incedent }, formats: [:text]))
    end
  end

  def incedent_stoped(incedent)
    @incedent = incedent

    mail(to: incedent.initiator.email+(incedent.has_observers? ? ', '+incedent.observers.all.collect(&:email).join(", ") : ''), subject: "Жалоба №#{incedent.id} остановлена")

    if (@incedent.initiator.jabber)
      send_jabber_message(@incedent.initiators, "Жалоба №#{incedent.id} остановлена", (render 'incedent_mailer/incedent_stoped', locals: { incedent: @incedent }, formats: [:text]))
    end

    if (@incedent.has_observers?)
      send_jabber_message(@incedent.observers, "Жалоба №#{incedent.id} остановлена", (render 'incedent_mailer/incedent_stoped', locals: { incedent: @incedent }, formats: [:text]))
    end
  end

  def incedent_replayed(incedent)
    @incedent = incedent

    mail(to: (incedent.has_workers? ? incedent.workers.all.collect(&:email).join(", ") : incedent.initiator.email)+(incedent.has_observers? ? ', '+incedent.observers.all.collect(&:email).join(", ") : ''), subject: "Жалоба №#{incedent.id} возобновлена")

    if (@incedent.initiator.jabber)
      send_jabber_message(@incedent.initiator.jabber, "Жалоба №#{incedent.id} возобновлена", (render 'incedent_mailer/incedent_replayed', locals: { incedent: @incedent }, formats: [:text]))
    end

    if (@incedent.has_workers?)
      send_jabber_message(@incedent.workers, "Жалоба №#{incedent.id} возобновлена", (render 'incedent_mailer/incedent_replayed', locals: { incedent: @incedent }, formats: [:text]))
    end

    if (@incedent.has_observers?)
      send_jabber_message(@incedent.observers, "Жалоба №#{incedent.id} возобновлена", (render 'incedent_mailer/incedent_replayed', locals: { incedent: @incedent }, formats: [:text]))
    end
  end

  def incedent_worked(incedent)
    @incedent = incedent

    mail(to: (incedent.has_workers? ? incedent.workers.all.collect(&:email).join(", ") : incedent.initiator.email)+(incedent.has_observers? ? ', '+incedent.observers.all.collect(&:email).join(", ") : ''), subject: "Жалоба №#{incedent.id} передана в работу")

    if (@incedent.initiator.jabber)
      send_jabber_message(@incedent.initiator.jabber, "Жалоба №#{incedent.id} передана в работу", (render 'incedent_mailer/incedent_worked', locals: { incedent: @incedent }, formats: [:text]))
    end

    if (@incedent.has_workers?)
      send_jabber_message(@incedent.workers, "Жалоба №#{incedent.id} передана в работу", (render 'incedent_mailer/incedent_worked', locals: { incedent: @incedent }, formats: [:text]))
    end

    if (@incedent.has_observers?)
      send_jabber_message(@incedent.observers, "Жалоба №#{incedent.id} передана в работу", (render 'incedent_mailer/incedent_worked', locals: { incedent: @incedent }, formats: [:text]))
    end
  end

  def incedent_rejected(incedent)
    @incedent = incedent

    mail(to: incedent.initiator.email+(incedent.has_observers? ? ', '+incedent.observers.all.collect(&:email).join(", ") : ''), subject: "Жалоба №#{incedent.id} отклонена")

    if (@incedent.initiator.jabber)
      send_jabber_message(@incedent.initiator.jabber, "Жалоба №#{incedent.id} отклонена", (render 'incedent_mailer/incedent_rejected', locals: { incedent: @incedent }, formats: [:text]))
    end

    if (@incedent.has_observers?)
      send_jabber_message(@incedent.observers, "Жалоба №#{incedent.id} отклонена", (render 'incedent_mailer/incedent_rejected', locals: { incedent: @incedent }, formats: [:text]))
    end
  end

  def incedent_reviewed(incedent)
    @incedent = incedent

    mail(to: incedent.initiator.email+(incedent.has_observers? ? ', '+incedent.observers.all.collect(&:email).join(", ") : ''), subject: "Жалоба №#{incedent.id} согласована")

    if (@incedent.initiator.jabber)
      send_jabber_message(@incedent.initiator.jabber, "Жалоба №#{incedent.id} согласована", (render 'incedent_mailer/incedent_reviewed', locals: { incedent: @incedent }, formats: [:text]))
    end

    if (@incedent.has_observers?)
      send_jabber_message(@incedent.observers, "Жалоба №#{incedent.id} согласована", (render 'incedent_mailer/incedent_reviewed', locals: { incedent: @incedent }, formats: [:text]))
    end
  end

  def incedent_solved(incedent)
    @incedent = incedent

    mail(to: (incedent.has_workers? ? incedent.workers.all.collect(&:email).join(", ") : incedent.initiator.email)+(incedent.has_observers? ? ', '+incedent.observers.all.collect(&:email).join(", ") : ''), subject: "Жалоба №#{incedent.id} решена")

    if (@incedent.has_workers?)
      send_jabber_message(@incedent.workers, "Жалоба №#{incedent.id} решена", (render 'incedent_mailer/incedent_solved', locals: { incedent: @incedent }, formats: [:text]))
    end

    if (@incedent.has_observers?)
      send_jabber_message(@incedent.observers, "Жалоба №#{incedent.id} решена", (render 'incedent_mailer/incedent_solved', locals: { incedent: @incedent }, formats: [:text]))
    end
  end

  def incedent_closed(incedent)
    @incedent = incedent

    mail(to: incedent.initiator.email+(incedent.has_observers? ? ', '+incedent.observers.all.collect(&:email).join(", ") : ''), subject: "Жалоба №#{incedent.id} закрыта")

    if (@incedent.initiator.jabber)
      send_jabber_message(@incedent.initiator.jabber, "Жалоба №#{incedent.id} закрыта", (render 'incedent_mailer/incedent_closed', locals: { incedent: @incedent }, formats: [:text]))
    end

    if (@incedent.has_observers?)
      send_jabber_message(@incedent.observers, "Жалоба №#{incedent.id} закрыта", (render 'incedent_mailer/incedent_closed', locals: { incedent: @incedent }, formats: [:text]))
    end
  end

  def incedents_in_progress(incedents, user)
    @incedents = incedents

    mail(to: user.email, subject: "Список незавершенных жалоб") if user.email
    send_jabber_message(user.jabber, "Список незавершенных жалоб", (render 'incedent_mailer/incedents_in_progress', locals: { incedents: @incedents }, formats: [:text])) if user.jabber
  end

end
