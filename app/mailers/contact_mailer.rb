class ContactMailer < ApplicationMailer
  def contact_mail(contact)
    @contact = contact
    mail to: "sample@email.com", subject: "confirmation"
  end
end
