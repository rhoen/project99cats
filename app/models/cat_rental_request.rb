class CatRentalRequest < ActiveRecord::Base
  validates :cat_id, :start_date, :end_date, presence: true
  validates :status, inclusion: { in: ["APPROVED", "DENIED", "PENDING"]}
  validate :check_approved_requests, :check_date_order

  belongs_to :cat

  after_initialize do
    self.status ||= "PENDING"
  end

  def approve!
    CatRentalRequest.transaction do
      self.status = "APPROVED"
      self.save!
      overlapping_pending_requests.update_all(status: "DENIED")
    end
  end

  def deny!
    self.status = "DENIED"
    self.save!
  end

  def pending?
    self.status == "PENDING"
  end

  protected

  def overlapping_pending_requests
    overlapping_requests.where(status: "PENDING")
  end

  def overlapping_approved_requests
    overlapping_requests.where(status: "APPROVED")
  end

  def overlapping_requests
    CatRentalRequest.where(<<-SQL, start_date: self.start_date, end_date: self.end_date, cat_id: self.cat_id, id: (self.id || 0))
    NOT(
      cat_rental_requests.start_date > :end_date
    OR
      cat_rental_requests.end_date < :start_date
    ) AND
    cat_rental_requests.cat_id = :cat_id
    AND
    cat_rental_requests.id != :id
    SQL
  end

  private

  def check_date_order
    if self.start_date && self.end_date && (self.end_date < self.start_date)
      errors[:end_date] << "End date must be after start date, " +
      "our cats cannot travel through time"
    end
  end

  def check_approved_requests
    unless overlapping_approved_requests.empty?
      errors[:cat_id] << "#{Cat.find(self.cat_id).name} is busy between those days!"
    end
  end


end
