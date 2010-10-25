#!/usr/bin/env ruby


# RNN��SOAP�����ӥ������Ѥ��륵��ץ�Ǥ����ܺ٤ˤĤ��Ƥϡ�
# http://cvs.sourceforge.jp/cgi-bin/viewcvs.cgi/*checkout*/rnn/rnn/doc/articles/xmlrpc.txt
# �����
# http://rwiki.jin.gr.jp/cgi-bin/rw-cgi.rb?cmd=view;name=RNN%A4%C8SOAP4R%A4%C7%CD%B7%A4%DC%A4%A6
# �򻲾Ȥ��Ƥ���������


require 'soap/wsdlDriver'
#wsdl = 'http://cvs.sourceforge.jp/cgi-bin/viewcvs.cgi/*checkout*/rnn/rnn/app/rnn-hash.wsdl'
wsdl = 'rnn-hash.wsdl'
rnn = SOAP::WSDLDriverFactory.new(wsdl).create_rpc_driver
rnn.generate_explicit_type = true
rnn.wiredump_dev = STDOUT

test_article_id = 1
POST_COMMENT_DIRECT = 0


# ���դǿ�������˥����Ȥ��ơ�pos���ܤ���n�ĤΥ˥塼������Ф��ޤ�
pos = 0
n = 5
topicid = nil
puts rnn.list(pos, n, topicid)
exit

# ID�� id �ε�����������ޤ�
rnn.article(test_article_id).each do |k, v|
  puts "#{k}: #{v}"
end

# ID�� id �ε����ˤĤ��ƤΤ��٤ƤΥ����Ȥ�������ޤ�
puts rnn.comments(test_article_id)

# �Ƕ� days ���֤ε�����������ޤ�
days = 1
topic = nil
rnn.recent_articles(days, topic).each do |article|
  article.each do |k, v|
    puts "#{k}: #{v}"
  end
end

# �Ƕ� days ���֤Υ����Ȥ�������ޤ�
days = 1
rnn.recent_comments(days).each do |comment|
  comment.each do |k, v|
    puts "#{k}: #{v}"
  end
end

# �ȥԥå���ʬ�������������ޤ�
rnn.topics.each do |topic|
  topic.each do |k, v|
    puts "#{k}: #{v}"
  end
end
