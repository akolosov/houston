# encoding: utf-8
class IncedentMailer < ActionMailer::Base
  include ApplicationHelper

  default from: 'houston@taxinonstop.ru'

  def incedent_created(incedent)
    @incedent = incedent

    @emails = (User.users_by_role_id(1).all.empty? ? incedent.initiator.email : User.users_by_role_id(1).collect(&:email).join(", ")+", "+incedent.initiator.email )

    mail(to: @emails, subject: "Жалоба №#{incedent.id} создана")

    if (@incedent.initiator.jabber)
      send_jabber_message(@incedent.initiator.jabber, "Жалоба №#{incedent.id} создана", (render 'incedent_mailer/incedent_created', locals: { incedent: @incedent }, formats: [:text]))
    end
  end

  def incedent_commented(incedent_comment)
    @incedent_comment = incedent_comment

    mail(to: (incedent_comment.incedent.initiator == incedent_comment.comment.author ? (incedent_comment.incedent.worker ? incedent_comment.incedent.worker.email : incedent_comment.incedent.initiator.email) : incedent_comment.incedent.initiator.email), subject: "Жалоба №#{incedent_comment.incedent.id} прокомментирована")

    if (@incedent_comment.incedent.initiator.jabber)
      send_jabber_message(@incedent_comment.incedent.initiator.jabber, "Жалоба №#{incedent_comment.incedent.id} прокомментирована", (render 'incedent_mailer/incedent_commented', locals: { incedent_comment: @incedent_comment }, formats: [:text]))
    end

    if (@incedent_comment.incedent.worker) and (@incedent_comment.incedent.worker.jabber) and (@incedent_comment.incedent.worker.realname != @incedent_comment.incedent.initiator.realname)
      send_jabber_message(@incedent_comment.incedent.worker.jabber, "Жалоба №#{incedent_comment.incedent.id} прокомментирована", (render 'incedent_mailer/incedent_commented', locals: { incedent_comment: @incedent_comment }, formats: [:text]))
    end
  end

  def incedent_played(incedent)
    @incedent = incedent

    mail(to: incedent.initiator.email, subject: "Жалоба №#{incedent.id} принята в работу")

    if (@incedent.initiator.jabber)
      send_jabber_message(@incedent.initiator.jabber, "Жалоба №#{incedent.id} принята в работу", (render 'incedent_mailer/incedent_played', locals: { incedent: @incedent }, formats: [:text]))
    end
  end

  def incedent_paused(incedent)
    @incedent = incedent

    mail(to: incedent.initiator.email, subject: "Жалоба №#{incedent.id} приостановлена")

    if (@incedent.initiator.jabber)
      send_jabber_message(@incedent.initiator.jabber, "Жалоба №#{incedent.id} приостановлена", (render 'incedent_mailer/incedent_paused', locals: { incedent: @incedent }, formats: [:text]))
    end
  end

  def incedent_stoped(incedent)
    @incedent = incedent

    mail(to: incedent.initiator.email, subject: "Жалоба №#{incedent.id} остановлена")

    if (@incedent.initiator.jabber)
      send_jabber_message(@incedent.initiator.jabber, "Жалоба №#{incedent.id} остановлена", (render 'incedent_mailer/incedent_stoped', locals: { incedent: @incedent }, formats: [:text]))
    end
  end

  def incedent_replayed(incedent)
    @incedent = incedent

    mail(to: (incedent.worker ? incedent.worker.email : incedent.initiator.email), subject: "Жалоба №#{incedent.id} возобновлена")

    if (@incedent.initiator.jabber)
      send_jabber_message(@incedent.initiator.jabber, "Жалоба №#{incedent.id} возобновлена", (render 'incedent_mailer/incedent_replayed', locals: { incedent: @incedent }, formats: [:text]))
    end

    if (@incedent.worker) and (@incedent.worker.jabber) and (@incedent.worker.realname != @incedent.initiator.realname)
      send_jabber_message(@incedent.initiator.jabber, "Жалоба №#{incedent.id} возобновлена", (render 'incedent_mailer/incedent_replayed', locals: { incedent: @incedent }, formats: [:text]))
    end
  end

  def incedent_rejected(incedent)
    @incedent = incedent

    @emails = (User.users_by_role_id(1).all.empty? ? incedent.initiator.email : User.users_by_role_id(1).collect(&:email).join(", ")+", "+incedent.initiator.email )

    mail(to: @emails, subject: "Жалоба №#{incedent.id} отклонена")

    if (@incedent.initiator.jabber)
      send_jabber_message(@incedent.initiator.jabber, "Жалоба №#{incedent.id} отклонена", (render 'incedent_mailer/incedent_rejected', locals: { incedent: @incedent }, formats: [:text]))
    end
  end

  def incedent_solved(incedent)
    @incedent = incedent

    mail(to: (incedent.worker ? incedent.worker.email : incedent.initiator.email), subject: "Жалоба №#{incedent.id} решена")

    if (@incedent.worker) and (@incedent.worker.jabber)
      send_jabber_message(@incedent.worker.jabber, "Жалоба №#{incedent.id} решена", (render 'incedent_mailer/incedent_solved', locals: { incedent: @incedent }, formats: [:text]))
    end
  end

  def incedent_closed(incedent)
    @incedent = incedent

    mail(to: incedent.initiator.email, subject: "Жалоба №#{incedent.id} закрыта")

    if (@incedent.initiator.jabber)
      send_jabber_message(@incedent.initiator.jabber, "Жалоба №#{incedent.id} закрыта", (render 'incedent_mailer/incedent_closed', locals: { incedent: @incedent }, formats: [:text]))
    end
  end

end
