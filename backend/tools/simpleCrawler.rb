# WebCrawler for isLabOpen
require 'nokogiri'
require 'open-uri'

doc = Nokogiri::HTML(open("http://sas.sor.ufscar.br/"), nil, 'EU')
#html = File.open('hehe.htm', 'r').read
#doc = Nokogiri::HTML(html, nil, 'EU')

doc = doc.css('table#quadroReservaDia')[0]
doc.xpath('//@style').remove
labs = doc.css('thead tr')

numberLSO = -1

numberLabs = 0
labs.css('tr th a font').each do |el|
  if el.text != "Reservas somente com o técnico responsável."
    if el.text.strip == "Laboratório Sistemas Operacionais e Distribuídos"
      puts el.text.strip
      numberLSO = numberLabs
      puts numberLSO
    end
    numberLabs += 1
  end
end

numberSubjects = 0
hour = 7
doc.search('td:empty').each{ |n| n.add_child "<font color=\"ff000\">Vazio</font>"}

flag = 0

#puts DateTime.now.change({ hour: 7 }).localtime("-03:00")
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
        #Subject.create(:begin => DateTime.now.change({ hour: hour }).localtime("-03:00"), :end => DateTime.now.change({ hour: hour + 1 }).localtime("-03:00"), :title => el.text, :laboratory_id => 1, :isFreeToJoin => false)
      else
        #Subject.create(:begin => DateTime.now.change({ hour: hour }).localtime("-03:00"), :end => DateTime.now.change({ hour: hour + 1 }).localtime("-03:00"), :title => el.text, :laboratory_id => 1, :isFreeToJoin => true)
      end
      hour += 1
    end
  end

  numberSubjects+=1
end

