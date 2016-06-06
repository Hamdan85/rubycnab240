class RubyCnab240::Arquivo::Lote::Header < RubyCnab240::Arquivo::Lote
  attr_accessor :codigo_do_banco_na_compensacao
  attr_accessor :lote_do_servico
  attr_accessor :forma_de_lancamento
  attr_accessor :tipo_de_inscricao_da_empresa
  attr_accessor :numero_de_inscricao_da_empresa
  attr_accessor :codigo_do_convenio_do_banco
  attr_accessor :agencia_mantenedora_da_conta
  attr_accessor :digito_verificador_da_agencia
  attr_accessor :numero_da_conta_corrente
  attr_accessor :digito_verificador_da_conta
  attr_accessor :digito_verificador_da_agencia_e_conta
  attr_accessor :nome_da_empresa
  attr_accessor :campos_opcionais_de_endereco

  attr_reader :uso_exclusivo_febraban
  attr_reader :tipo_de_registro
  attr_reader :tipo_de_operacao
  attr_reader :tipo_de_servico
  attr_reader :bb2
  attr_reader :bb3
  attr_reader :bb4
  attr_reader :mensagem_1
  attr_reader :uso_exclusivo_febraban2
  attr_reader :codigo_para_ocorrencias_de_retorno
  attr_reader :numero_da_versao_do_leiaute_do_lote

  def initialize(fields = {})
    @codigo_do_banco_na_compensacao = fields[:codigo_do_banco_na_compensacao].to_s[0..2].rjust(3, '0') #default: 001
    @lote_do_servico = fields[:lote_do_servico].to_s[0..3].rjust(4, '0')
    @tipo_de_registro = fields[:tipo_de_registro] = '1'
    @tipo_de_operacao = fields[:tipo_de_operacao] = 'C'
    @tipo_de_servico = fields[:tipo_de_servico] = '20' #Os tipos de serviços aceitos pelo BB são somente '20' (Pagamento a Fornecedores), '30' (Pagamento de Salários) e '98' (Pagamentos Diversos).
    @forma_de_lancamento = fields[:forma_de_lancamento] || '41'  #Formas de lançamentos aceitos pelo BB quando utilizados os segmentos A e B : 01 para Crédito em Conta Corrente, 02 para Pagamento Contra0Recibo, 03 para DOC/TED, 04 para Cartão Salário, 05 para Crédito em Conta Poupança, 10 para Ordem de Pagamento, 41 para TED Outra Titularidade, e 43 para TED Mesma Titularidade. Obs.: no caso da forma de lançamento 03, 41 ou 43, há complementação de informação do campo “Código da Câmara de Compensação”, posições 18 a 20 do segmento A.
    @numero_da_versao_do_leiaute_do_lote = '031' #Campo não criticado pelo sistema. Informar Zeros OU se preferir, informar número da versão do leiaute do Lote que foi utilizado como base para formatação dos campos. Versões disponíveis: 043, 042, 041, 040, 031, 030 ou 020. A versão do Lote quando informada deve estar condizente com a versão do Arquivo (posições 164 a 166 do Header de Arquivo). Ou seja, para utilizar 043 no lote o Header do arquivo deve conter 084, para 042 no lote o Header do arquivo deve conter 083 ou 082, para 041 ou 040 no lote o Header do arquivo deve conter 080, para 031 no lote o Header do arquivo deve conter 050, para 030 no lote o Header do Arquivo deve conter 040, e para 020 no lote o Header do Arquivo deve conter 030.
    @uso_exclusivo_febraban = ' '
    @tipo_de_inscricao_da_empresa = fields[:tipo_de_inscricao_da_empresa].to_s[0..0].rjust(1, '0') #1 – para CPF e 2 – para CNPJ.
    @numero_de_inscricao_da_empresa = fields[:numero_de_inscricao_da_empresa].to_s[0..13].rjust(14, '0') #Informar número da inscrição (CPF ou CNPJ) da Empresa, alinhado à direita com zeros à esquerda.

    #Codigo do Convenio do Banco
    @codigo_do_convenio_do_banco = fields[:codigo_do_convenio_do_banco].to_s[0..8].rjust(9, '0') #Informar o convênio de pagamento, completando com zeros à esquerda
    @bb2 = fields[:bb2] = '0126'
    @bb3 = fields[:bb3] = '     '
    @bb4 = fields[:bb4] = '  '

    @agencia_mantenedora_da_conta = fields[:agencia_mantenedora_da_conta].to_s[0..4].rjust(5, '0')
    @digito_verificador_da_agencia = fields[:digito_verificador_da_agencia].to_s[0..0].upcase.rjust(1, '0')
    @numero_da_conta_corrente = fields[:numero_da_conta_corrente].to_s[0..11].rjust(12, '0')
    @digito_verificador_da_conta = fields[:digito_verificador_da_conta].to_s[0..0].upcase.rjust(1, '0')
    @digito_verificador_da_agencia_e_conta = '0'
    @nome_da_empresa = fields[:nome_da_empresa].to_s[0..29].upcase.rjust(30, ' ')

    @mensagem_1 = fields[:mensagem_1] = '                                        '
    @campos_opcionais_de_endereco = fields[:campos_opcionais_de_endereco].to_s[0..79].upcase.ljust(80, ' ')
    @uso_exclusivo_febraban2 = '        '
    @codigo_para_ocorrencias_de_retorno = '          '
  end

  def to_string
    header = String.new

    header << self.codigo_do_banco_na_compensacao
    header << self.lote_do_servico
    header << self.tipo_de_registro
    header << self.tipo_de_operacao
    header << self.tipo_de_servico
    header << self.forma_de_lancamento
    header << self.numero_da_versao_do_leiaute_do_lote
    header << self.uso_exclusivo_febraban
    header << self.tipo_de_inscricao_da_empresa
    header << self.numero_de_inscricao_da_empresa
    header << self.codigo_do_convenio_do_banco
    header << self.bb2
    header << self.bb3
    header << self.bb4
    header << self.agencia_mantenedora_da_conta
    header << self.digito_verificador_da_agencia
    header << self.numero_da_conta_corrente
    header << self.digito_verificador_da_conta
    header << self.digito_verificador_da_agencia_e_conta
    header << self.nome_da_empresa
    header << self.mensagem_1
    header << self.campos_opcionais_de_endereco
    header << self.uso_exclusivo_febraban2
    header << self.codigo_para_ocorrencias_de_retorno
  end
end