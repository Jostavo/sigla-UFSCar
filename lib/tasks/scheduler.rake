desc "This task is called by the Heroku scheduler add-on"
task :update_subjects => :environment do
  Subject.delete_all

  # WebCrawler for isLabOpen
  require 'nokogiri'
  require 'open-uri'

  doc = Nokogiri::HTML(open("http://sas.sor.ufscar.br/"), nil, 'EU')

  doc = doc.css('table#quadroReservaDia')[0]
  doc.xpath('//@style').remove
  labs = doc.css('thead tr')

  numberLSO = -1

  numberLabs = 0
  labs.css('tr th a font').each do |el|
    if el.text != "Reservas somente com o técnico responsável."
      if el.text.strip == "Laboratório Sistemas Operacionais e Distribuídos"
        #if el.text.strip == "Laboratório de Ensino de Computação (LEC)"
        puts el.text.strip
        numberLSO = numberLabs
        puts numberLSO
      end
      numberLabs += 1
    end
  end

  numberSubjects = 0
  hour = 8
  doc.search('td:empty').each{ |n| n.add_child "<font color=\"ff000\">Vazio</font>"}

  flag = 0

  puts DateTime.now.change({ hour: 8 }).localtime("-03:00")
  puts DateTime.now
  doc.css('tbody tr td font').each do |el|
    if flag == 0
      if numberSubjects == numberLSO
        flag = 1
        numberSubjects = 0
      end
    else
      if numberSubjects % numberLabs == 0
        puts el.text
        if el.text != "Vazio"
          Laboratory.find_by(:initials => "LSO").subjects.create(:begin_time => DateTime.now.change({ hour: hour }).localtime("-03:00"), :end_time => DateTime.now.change({ hour: hour+1}).localtime("-03:00"), :title => el.text, :isFreeToJoin => false)
        else
          Laboratory.find_by(:initials => "LSO").subjects.create(:begin_time => DateTime.now.change({ hour: hour }).localtime("-03:00"), :end_time => DateTime.now.change({ hour: hour+1}).localtime("-03:00"), :title => el.text, :isFreeToJoin => true)
        end
        hour += 1
      end
    end

    numberSubjects+=1
  end
end
