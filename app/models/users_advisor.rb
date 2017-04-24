class UsersAdvisor < ApplicationRecord
  belongs_to :professor, class_name: "User", foreign_key: "professor_id"
  belongs_to :student, class_name: "User", foreign_key: "student_id"
end
