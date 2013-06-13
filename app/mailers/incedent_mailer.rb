# encoding: utf-8
class IncedentMailer < ActionMailer::Base
  default from: 'houston@taxinonstop.ru'

  def incedent_created(incedent)
    @incedent = incedent

    @emails = (User.users_by_role_id(1).all.empty? ? incedent.initiator.email : User.users_by_role_id(1).collect(&:email).join(", ")+", "+incedent.initiator.email )

    mail(to: @emails, subject: "Жалоба №#{incedent.id} создана")
  end

  def incedent_commented(incedent_comment)
    @incedent_comment = incedent_comment

    mail(to: (incedent_comment.incedent.initiator == incedent_comment.comment.author ? (incedent_comment.incedent.worker ? incedent_comment.incedent.worker.email : incedent_comment.incedent.initiator.email) : incedent_comment.incedent.initiator.email), subject: "Жалоба №#{incedent_comment.incedent.id} прокомментирована")
  end

  def incedent_played(incedent)
    @incedent = incedent

    mail(to: incedent.initiator.email, subject: "Жалоба №#{incedent.id} принята в работу")
  end

  def incedent_paused(incedent)
    @incedent = incedent

    mail(to: incedent.initiator.email, subject: "Жалоба №#{incedent.id} приостановлена")
  end

  def incedent_stoped(incedent)
    @incedent = incedent

    mail(to: incedent.initiator.email, subject: "Жалоба №#{incedent.id} остановлена")
  end

  def incedent_replayed(incedent)
    @incedent = incedent

    mail(to: (incedent.worker ? incedent.worker.email : incedent.initiator.email), subject: "Жалоба №#{incedent.id} возобновлена")
  end

  def incedent_rejected(incedent)
    @incedent = incedent

    @emails = (User.users_by_role_id(1).all.empty? ? incedent.initiator.email : User.users_by_role_id(1).collect(&:email).join(", ")+", "+incedent.initiator.email )

    mail(to: @emails, subject: "Жалоба №#{incedent.id} отклонена")
  end

  def incedent_solved(incedent)
    @incedent = incedent

    mail(to: (incedent.worker ? incedent.worker.email : incedent.initiator.email), subject: "Жалоба №#{incedent.id} решена")
  end

  def incedent_closed(incedent)
    @incedent = incedent

    mail(to: incedent.initiator.email, subject: "Жалоба №#{incedent.id} закрыта")
  end

end
