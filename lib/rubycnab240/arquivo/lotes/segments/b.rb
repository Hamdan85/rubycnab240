class RubyCnab240::Arquivo::Lote::Segment::B < RubyCnab240::Arquivo::Lote::Segment
  attr_accessor :codigo_do_banco_na_compensacao
  attr_accessor :lote_do_servico
  attr_accessor :tipo_de_registro
  attr_accessor :numero_sequencial_de_registro_no_lote
  attr_accessor :tipo_de_inscricao_do_favorecido
  attr_accessor :numero_de_inscricao_do_favorecido
  attr_accessor :aviso_ao_favorecido
  attr_accessor :campos_de_endereco_opcionais

  attr_reader :codigo_segmento_do_registro_detalhe
  attr_reader :uso_exclusivo_do_siape
  attr_reader :uso_exclusivo_febraban
  attr_reader :uso_exclusivo_febraban2

  def initialize(fields = {})

    @codigo_do_banco_na_compensacao =  fields[:codigo_do_banco_na_compensacao].to_s[0..2].rjust(3, '0') #default: 001
    @lote_do_servico = fields[:lote_do_servico].to_s[0..3].rjust(4, '0')
    @tipo_de_registro = fields[:tipo_de_registro] = '3'
    @numero_sequencial_de_registro_no_lote = fields[:numero_sequencial_de_registro_no_lote].to_s[0..4].rjust(5, '0') #Começar com 00002 e ir incrementando em 1 a cada nova linha do registro detalhe, esse sequencial é continuação do segmento 'A' anterior.
    @codigo_segmento_do_registro_detalhe = 'B'
    @uso_exclusivo_febraban = ' ' * 3
    @tipo_de_inscricao_do_favorecido = fields[:tipo_de_inscricao_do_favorecido].to_s[0..0].rjust(1, '0') #Informação obrigatória para crédito via DOC/TED, saque on0line e ORPAG  e caso a empresa queira que o sistema confronte o CPF/CNPJ com a agência/conta do favorecido informada.
    @numero_de_inscricao_do_favorecido = fields[:numero_de_inscricao_do_favorecido].to_s[0..13].rjust(14, '0') #Informação obrigatória para crédito via DOC/TED, saque online, ORPAG  e caso a empresa queira que o sistema confronte o CPF/CNPJ com a agência/conta do favorecido informada. Neste último caso, deve ser solicitada para a agência que conste no cadastro do serviço para conferir número de inscrição do favorecido..
    @campos_de_endereco_opcionais = ' ' * 193
    @aviso_ao_favorecido = '0' #O ou 5 – o código 5 (com aviso) somente será tratado caso tenha sido negociado com a agência e conste no cadastramento do serviço a emissão de aviso.
    @uso_exclusivo_do_siape = ' ' * 6
    @uso_exclusivo_febraban2 = ' ' * 8
  end

  def to_string
    segmento = String.new

    segmento << self.codigo_do_banco_na_compensacao
    segmento << self.lote_do_servico
    segmento << self.tipo_de_registro
    segmento << self.numero_sequencial_de_registro_no_lote
    segmento << self.codigo_segmento_do_registro_detalhe
    segmento << self.uso_exclusivo_febraban
    segmento << self.tipo_de_inscricao_do_favorecido
    segmento << self.numero_de_inscricao_do_favorecido
    segmento << self.campos_de_endereco_opcionais
    segmento << self.aviso_ao_favorecido
    segmento << self.uso_exclusivo_do_siape
    segmento << self.uso_exclusivo_febraban2
  end
end