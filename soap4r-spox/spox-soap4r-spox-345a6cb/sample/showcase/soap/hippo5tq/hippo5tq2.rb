#!/usr/bin/env ruby

$KCODE = 'SJIS'

proxy = ARGV.shift || nil

require 'soap/driver'

# XML Schema Datatypes��1999�ł��w��i�͂�Ȃ��Ȃ��Ă���j
require 'soap/XMLSchemaDatatypes1999'

# Wiredump�̏o�͐�
def getWireDumpLogFile
  logFilename = File.basename( $0 ) + '.log'
  f = File.open( logFilename, 'w' )
  f << "File: #{ logFilename } - Wiredumps for SOAP4R client / #{ $serverName } server.\n"
  f << "Date: #{ Time.now }\n\n"
end

# �T�[�r�X���̓o�^�i�{���Ȃ�WSDL��������ׂ��Ƃ���j
Server = 'http://www.hippo2000.net/cgi-bin/soap5tq2.cgi'
NS = 'urn:Soap5tq2'

drv = SOAP::Driver.new( nil, 'hippo5tq', NS, Server, proxy )
drv.setWireDumpDev( getWireDumpLogFile )

drv.addMethod( 'Init', 'UsrName', 'Passwd' )
  # => [ sSession, sErr ]
drv.addMethod( 'End', 'sSsID' )
  # => void
drv.addMethod( 'GetQuizAll', 'sSsId' )
  # => [ sQuiz0, sOpt00, sOpt01, sOpt02, sOpt03, sOpt04,
  #      ...
  #      sQuiz9, sOpt90, sOpt91, sOpt92, sOpt93, sOpt94 ]
drv.addMethod( 'RepQuizAll', 'sSsID', 'iRes' )
  # => [ iResult, iPoint ]
drv.addMethod( 'GetQuiz', 'sSsID' )
  # => [ sQuiz, sOpt0, sOpt1, sOpt2, sOpt3, sOpt4 ]
drv.addMethod( 'ReqQuiz', 'sSsID', 'iRes' )
  # => [ iResult, iPoint ]


# �N�C�Y�T�[�r�X�ւ̃��O�C��
sessionId, errInfo =  drv.Init( 'SOAP4R', '' )

totalPoint = 0

# ���f���B�B�B
trap( "INT" ) do | sig |
  puts "���f����܂���"
  drv.End( sessionId )
  exit( -1 )
end

# �ŏ��Ɉꊇ���ăN�C�Y���擾���Ă��܂�
quizAll = drv.GetQuizAll( sessionId )

# ���׍H���\�b�h���d����
def quizAll.next
  quiz, opt1, opt2, opt3, opt4, opt5 = self.slice!( 0..5 )
  return quiz, opt1, opt2, opt3, opt4, opt5
end

def quizAll.eof?
  ( self.length < 6 )
end

# �N�C�Y�J�n

# �N�C�Y�̎c���Ă�ԁB�B�B
while !quizAll.eof?
  quiz, *opt = quizAll.next

  # �o��
  puts '-' * 78
  puts quiz
  1.upto( opt.length ) do | i |
    puts "#{ i }: #{ opt[ i-1 ] }"
  end

  # ��
  ans = gets.chomp.to_i

  # �񓚂��ƍ�����
  result, point = drv.RepQuizAll( sessionId, ans - 1 )

  # ���茋�ʂ�?
  unless result.zero?
    puts "���� ���_: #{ point }"
    totalPoint += point
  else
    puts "�n�Y��"
  end
end

puts "Total: #{ totalPoint }"

# ���O�I�t
drv.End( sessionId )
