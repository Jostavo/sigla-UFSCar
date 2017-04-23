desc "This task check all biometrics in the laboratory to changes the status"

task :check_biometrics => :environment do
  laboratories = Laboratory.all

  laboratories.each do |lab|
    lab.authorized_person.each do |aut|
      if (DateTime.now > aut.created_at )
        if not aut.user.function.eql?('admin')
          aut.update_attributes(:status => 'expired')
        end
      end
    end
  end

end
