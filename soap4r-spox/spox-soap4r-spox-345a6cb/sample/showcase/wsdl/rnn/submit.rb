require 'soap/wsdlDriver'
wsdl = 'http://cvs.sourceforge.jp/cgi-bin/viewcvs.cgi/*checkout*/rnn/rnn/app/rnn-hash.wsdl'
rnn = SOAP::WSDLDriverFactory.new(wsdl).create_rpc_driver
rnn.generate_explicit_type = true
rnn.wiredump_dev = STDOUT

topic_map = {}
rnn.topics.each do |topic|
  topic_id = topic['topic_id']
  topic['children'] = {}
  topic_map[topic_id] = topic
end

topic_tree = {}
topic_map.each do |id, topic|
  topic_pid = topic['topic_pid']
  topic_title = topic['topic_title']
  if topic_pid.zero?
    topic_tree[topic_title] = topic
  else
    topic_map[topic_pid]['children'][topic_title] = topic
  end
end

topic_id = topic_tree['�饤�֥��']['children']['XML']['topic_id']

title = "soap4r/1.4.8.1����꡼�����줿"
text =<<'__EOS__'
soap4r/1.4.8.1����꡼�����줿��

1.4.7������ѹ����ϰʲ����̤ꡣ
* Ruby/1.8���ѻ���ȯ������warning���Фʤ��褦�ˤ��ޤ�����
* WSDL���ɤߡ����饤����Ȥ����ñ�˥᥽�åɤ�ƤӽФ���褦�ˤ���
  wsdlDriver���ɲä��ޤ�����Google�򸡺����륵��ץ롣 
    require 'soap/wsdlDriver'
    searchWord = ARGV.shift
    # http://www.google.com/apis/����饤���󥹥������������ɬ�פ�����ޤ���
    key = File.open(File.expand_path("~/.google_key")).read.chomp
    GOOGLE_WSDL = 'http://api.google.com/GoogleSearch.wsdl'
    # Load WSDL and create driver.
    google = SOAP::WSDLDriverFactory.new(GOOGLE_WSDL).create_rpc_driver
    # Just invoke!
    result = google.doGoogleSearch(key, searchWord, 0, 10, false, "", false, "", 'utf-8', 'utf-8')
    result.resultElements.each do |ele|
      puts "== #{ele.title}: #{ele.URL}"
      puts ele.snippet
      puts
    end
  ����ץ�Ȥ��ơ�AmazonWebServices��RAA��RNN��wsdlDriver���ѥץ�����
  sample�ǥ��쥯�ȥ���֤��Ƥ���ޤ���
* xmlscan�Υ��ݡ��ȡ�
* XML processor�θ��м����ѹ���xmlscan��REXML��XMLParser��NQXML�ν��
  �������ޤ���
* ���������ɥϥ�ɥ�󥰤�����euc-jp�⤷����shift_jis��Ȥ�����ˤϡ�
  xmlscan-0.2��Ȥ���uconv�⥸�塼�뤬�ʤ��Ƥ⤫�ޤ��ޤ��󡣤���¾��XML
  processor��Ȥ�����uconv�⥸�塼�뤬ɬ�פǤ���
* cgistub.rb: SOAP�쥹�ݥ󥹤Υ�ǥ��������פ��ѹ��Ǥ���褦�ˤ�����
  ��������Java�ǡ�text/xml�򿩤�ʤ���Ĥ�����������
* wsdl2ruby: --force���ץ������ɲä��ޤ�����
* ��������ΥХ�������
__EOS__

p rnn.submit(title, text, topic_id)
