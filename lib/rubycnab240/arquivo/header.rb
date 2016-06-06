class RubyCnab240::Arquivo::Header < RubyCnab240::Arquivo
  attr_accessor :codigo_do_banco_na_compensacao
  attr_accessor :lote_do_servico
  attr_accessor :tipo_de_registro
  attr_accessor :tipo_de_inscricao_da_empresa
  attr_accessor :numero_de_inscricao_da_empresa
  attr_accessor :codigo_do_convenio_do_banco
  attr_accessor :agencia_mantenedora_da_conta
  attr_accessor :digito_verificador_da_agencia
  attr_accessor :numero_da_conta_corrente
  attr_accessor :digito_verificador_da_conta
  attr_accessor :digito_verificador_da_agencia_e_conta
  attr_accessor :nome_da_empresa
  attr_accessor :nome_do_banco
  attr_accessor :codigo_remessa_retorno
  attr_accessor :numero_sequencial_de_arquivo
  attr_accessor :para_uso_reservado_da_empresa

  attr_reader :uso_exclusivo_febraban
  attr_reader :uso_exclusivo_febraban2
  attr_reader :uso_exclusivo_febraban3

  def initialize(fields = {})
    @codigo_do_banco_na_compensacao = fields[:codigo_do_banco_na_compensacao].to_s[0..2].rjust(3, '0') #default: 001
    @lote_do_servico = fields[:lote_do_servico].to_s[0..3].rjust(4, '0')
    @tipo_de_registro = fields[:tipo_de_registro].to_s[0..0].rjust(1, '0')
    @uso_exclusivo_febraban = ' ' * 9
    @tipo_de_inscricao_da_empresa = fields[:tipo_de_inscricao_da_empresa].to_s[0..0].rjust(1, '0') #1 – para CPF e 2 – para CNPJ.
    @numero_de_inscricao_da_empresa = fields[:numero_de_inscricao_da_empresa].to_s[0..13].rjust(14, '0') #Informar número da inscrição (CPF ou CNPJ) da Empresa, alinhado à direita com zeros à esquerda.

    #bb
    #Preencher com “0009999990126       “, onde 999999 informar o número do convênio de pagamento, alinhado à direita com zeros à esquerda seguido de “0126” para pagamento e demais posições com brancos (espaços).
    @codigo_do_convenio_do_banco = fields[:codigo_do_convenio_do_banco].to_s[0..8].rjust(9, '0') #Informar o convênio de pagamento, completando com zeros à esquerda;
    @bb2 = fields[:bb2] = '0126'
    @bb3 = fields[:bb3] = '     '
    @bb4 = fields[:bb4] = '  '

    @agencia_mantenedora_da_conta = fields[:agencia_mantenedora_da_conta].to_s[0..4].rjust(5, '0')
    @digito_verificador_da_agencia = fields[:digito_verificador_da_agencia].to_s[0..0].upcase.rjust(1, '0')
    @numero_da_conta_corrente = fields[:numero_da_conta_corrente].to_s[0..11].rjust(12, '0')
    @digito_verificador_da_conta = fields[:digito_verificador_da_conta].to_s[0..0].upcase.rjust(1, '0')
    @digito_verificador_da_agencia_e_conta = '0'

    @nome_da_empresa = fields[:nome_da_empresa].to_s[0..29].upcase.ljust(30, ' ')
    @nome_do_banco = fields[:nome_do_banco].to_s[0..29].upcase.ljust(30, ' ')
    @uso_exclusivo_febraban2 = '          '
    @codigo_remessa_retorno = '1' #1 – para arquivo remessa. 2 – quando arquivo retorno.
    @data_de_geracao_do_arquivo = Date.today.strftime("%d%m%Y")
    @hora_de_geracao_do_arquivo = Time.now.strftime("%H%M%S")
    @numero_sequencial_de_arquivo = fields[:numero_sequencial_de_arquivo].to_s[0..5].upcase.rjust(6, '0')
    @versao_do_leiaute_de_arquivo = '050'
    @densidade_de_gravacao_de_arquivo = '0' * 5
    @para_uso_reservado_do_banco = '                    '
    @para_uso_reservado_da_empresa = fields[:para_uso_reservado_da_empresa].to_s[0..19].rjust(20, ' ') #uso reservado da empresa
    @uso_exclusivo_febraban3 = '                             '
  end

  def to_string
    header = String.new

    header << @codigo_do_banco_na_compensacao
    header << @lote_do_servico
    header << @tipo_de_registro
    header << @uso_exclusivo_febraban
    header << @tipo_de_inscricao_da_empresa
    header << @numero_de_inscricao_da_empresa
    header << @codigo_do_convenio_do_banco
    header << @bb2
    header << @bb3
    header << @bb4
    header << @agencia_mantenedora_da_conta
    header << @digito_verificador_da_agencia
    header << @numero_da_conta_corrente
    header << @digito_verificador_da_conta
    header << @digito_verificador_da_agencia_e_conta
    header << @nome_da_empresa
    header << @nome_do_banco
    header << @uso_exclusivo_febraban2
    header << @codigo_remessa_retorno
    header << @data_de_geracao_do_arquivo
    header << @hora_de_geracao_do_arquivo
    header << @numero_sequencial_de_arquivo
    header << @versao_do_leiaute_de_arquivo
    header << @densidade_de_gravacao_de_arquivo
    header << @para_uso_reservado_do_banco
    header << @para_uso_reservado_da_empresa
    header << @uso_exclusivo_febraban3
  end
end