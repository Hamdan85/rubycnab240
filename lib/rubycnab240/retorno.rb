class RubyCnab240::Retorno

  attr_accessor :file
  attr_accessor :result

  def initialize(file)
    @file = file
    @result = []
  end

  def process

    lines = []

    File.foreach(self.file).with_index do |line, line_num|
      lines << { line_num: line_num, text: line }
    end

    lines.select{ |line| line[:text][13..13] == 'A' }.each do |segment_a|
      self.result << {
          line_num: segment_a[:line_num],
          identification: segment_a[:text][85..92],
          succeded: RubyCnab240::Retorno.success?(segment_a[:text][230..231]),
          return_code: segment_a[:text][230..23],
          return_message: RubyCnab240::Retorno.return_message(segment_a[:text][230..231]),
          date: Date.strptime(segment_a[:text][93..101],"%d%m%Y")
      }
    end

    self.result
  end

  def self.return_message(code)
    case code
      when '00'
        'CREDITO OU DEBITO EFETUADO'
      when '01'
        'INSUFICIENCIA DE FUNDOS - DEBITO NAO EFETUADO'
      when '02'
        'CREDITO OU DEBITO CANCELADO PELO PAGADOR/CREDOR'
      when '03'
        'DEBITO AUTORIZADO PELA AGENCIA - EFETUADO'
      when '88'
        'REMESSA DUPLICADA'
      when 'AA'
        'CONTROLE INVALIDO'
      when 'AB'
        'TIPO DE OPERACAO INVALIDO'
      when 'AC'
        'TIPO DE SERVICO INVALIDO'
      when 'AD'
        'FORMA DE LANCAMENTO INVALIDA'
      when 'AE'
        'TIPO/NUMERO DE INSCRICAO INVALIDO'
      when 'AF'
        'CODIGO DE CONVENIO INVALIDO'
      when 'AG'
        'AGENCIA/CONTA CORRENTE/DV INVALIDO'
      when 'AH'
        'No. SEQUENCIAL DO REGISTRO LOTE INVALIDO'
      when 'AI'
        'CODIGO DE SEGMENTO DE DETALHE INVALIDO'
      when 'AJ'
        'TIPO DE MOVIMENTO INVALIDO'
      when 'AK'
        'CODIGO DE COMPENSACAO DO FAVORECIDO/DEPOSITARIO INVALIDO'
      when 'AL'
        'BANCO DO FAVORECIDO OU DEPOSITARIO INVALIDO'
      when 'AM'
        'AGENCIA MANTENEDORA DA C.C. DO FAVOREDICO INVALIDA'
      when 'AO'
        'NOME DO FAVORECIDO INVALIDO'
      when 'AP'
        'DATA LANCAMENTO INVALIDA'
      when 'AQ'
        'TIPO/QUANTIDADE DA MOEDA INVALIDO'
      when 'AR'
        'VALOR DO LANCAMENTO INVALIDO'
      when 'AS'
        'AVISO AO FAVORECIDO - IDENTIFICACAO INVALIDA'
      when 'AT'
        'TIPO/NUMERO DE INSCRICAO DO FAVORECIDO INVALIDO'
      when 'AU'
        'LOGRADOURO DO FAVORECIDO NAO INFORMADO'
      when 'AV'
        'No. DO LOCAL DO FAVORECIDO NAO INFORMADO'
      when 'AW'
        'CIDADE DO FAVORECIDO NAO INFORMADO'
      when 'AX'
        'CEP/COMPLEMENTO DO FAVORECIDO INVALIDO'
      when 'AY'
        'SIGLA DO ESTADO DO FAVORECIDO INVALIDO'
      when 'AZ'
        'CODIGO/NOME DO BANCO DEPOSITARIO INVALIDO'
      when 'BA'
        'CODIGO/NOME DA AGENCIA DEPOSITARIA NAO INFORMADO'
      when 'BB'
        'SEU NUMERO INVALIDO'
      when 'BC'
        'NOSSO NUMERO INVALIDO'
      when 'BD'
        'CONFIRMACAO DE PAGAMENTO AGENDADO'
      when 'CF'
        'VALOR DO DOCUMENTO INVALIDO'
      when 'HB'
        'LOTE NAO ACEITO'
      when 'HC'
        'CONVENIO COM A EMPRESA INEXISTENTE/INVALIDO PARA O CONTRATO'
      when 'HD'
        'AGENCIA/CONTA DA EMPRESA INEXISTENTE/INVALIDA P/ CONTRATO'
      when 'HE'
        'TIPO DE SERVICO INVALIDO P/ CONTRATO'
      when 'HF'
        'CONTA CORRENTE DA EMPRESA COM SALDO INSUFICIENTE'
      when 'HG'
        'LOTE DE SERVICO FORA DE SEQUENCIA'
      when 'HH'
        'LOTE DE SERVICO INVALIDO'
      when 'NA'
        'CONTA CORRENTE/DV DO FAVORECIDO INVALIDO'
      when 'TA'
        'LOTE NAO ACEITO - TOTAIS DO LOTE COM DIFERENCA'
      else
        'IDENTIFICADOR NÃO EXISTENTE OU NÃO RECONHECIDO'
    end
  end

  def self.success?(code)
    case code
      when '00'
        #'CREDITO OU DEBITO EFETUADO'
        true
      when '01'
        #'INSUFICIENCIA DE FUNDOS - DEBITO NAO EFETUADO'
        false
      when '02'
        #'CREDITO OU DEBITO CANCELADO PELO PAGADOR/CREDOR'
        false
      when '03'
        #'DEBITO AUTORIZADO PELA AGENCIA - EFETUADO'
        true
      when '88'
        #'REMESSA DUPLICADA'
        false
      when 'AA'
        #'CONTROLE INVALIDO'
        false
      when 'AB'
        #'TIPO DE OPERACAO INVALIDO'
        false
      when 'AC'
        #'TIPO DE SERVICO INVALIDO'
        false
      when 'AD'
        #'FORMA DE LANCAMENTO INVALIDA'
        false
      when 'AE'
        #'TIPO/NUMERO DE INSCRICAO INVALIDO'
        false
      when 'AF'
        #'CODIGO DE CONVENIO INVALIDO'
        false
      when 'AG'
        #'AGENCIA/CONTA CORRENTE/DV INVALIDO'
        false
      when 'AH'
        #'No. SEQUENCIAL DO REGISTRO LOTE INVALIDO'
        false
      when 'AI'
        #'CODIGO DE SEGMENTO DE DETALHE INVALIDO'
        false
      when 'AJ'
        #'TIPO DE MOVIMENTO INVALIDO'
        false
      when 'AK'
        #'CODIGO DE COMPENSACAO DO FAVORECIDO/DEPOSITARIO INVALIDO'
        false
      when 'AL'
        #'BANCO DO FAVORECIDO OU DEPOSITARIO INVALIDO'
        false
      when 'AM'
        #'AGENCIA MANTENEDORA DA C.C. DO FAVOREDICO INVALIDA'
        false
      when 'AO'
        #'NOME DO FAVORECIDO INVALIDO'
        false
      when 'AP'
        #'DATA LANCAMENTO INVALIDA'
        false
      when 'AQ'
        #'TIPO/QUANTIDADE DA MOEDA INVALIDO'
        false
      when 'AR'
        #'VALOR DO LANCAMENTO INVALIDO'
        false
      when 'AS'
        #'AVISO AO FAVORECIDO - IDENTIFICACAO INVALIDA'
        false
      when 'AT'
        #'TIPO/NUMERO DE INSCRICAO DO FAVORECIDO INVALIDO'
        false
      when 'AU'
        #'LOGRADOURO DO FAVORECIDO NAO INFORMADO'
        false
      when 'AV'
        #'No. DO LOCAL DO FAVORECIDO NAO INFORMADO'
        false
      when 'AW'
        #'CIDADE DO FAVORECIDO NAO INFORMADO'
        false
      when 'AX'
        #'CEP/COMPLEMENTO DO FAVORECIDO INVALIDO'
        false
      when 'AY'
        #'SIGLA DO ESTADO DO FAVORECIDO INVALIDO'
        false
      when 'AZ'
        #'CODIGO/NOME DO BANCO DEPOSITARIO INVALIDO'
        false
      when 'BA'
        #'CODIGO/NOME DA AGENCIA DEPOSITARIA NAO INFORMADO'
        false
      when 'BB'
        #'SEU NUMERO INVALIDO'
        false
      when 'BC'
        #'NOSSO NUMERO INVALIDO'
        false
      when 'BD'
        #'CONFIRMACAO DE PAGAMENTO AGENDADO'
        true
      when 'CF'
        #'VALOR DO DOCUMENTO INVALIDO'
        false
      when 'HB'
        #'LOTE NAO ACEITO'
        false
      when 'HC'
        #'CONVENIO COM A EMPRESA INEXISTENTE/INVALIDO PARA O CONTRATO'
        false
      when 'HD'
        #'AGENCIA/CONTA DA EMPRESA INEXISTENTE/INVALIDA P/ CONTRATO'
        false
      when 'HE'
        #'TIPO DE SERVICO INVALIDO P/ CONTRATO'
        false
      when 'HF'
        #'CONTA CORRENTE DA EMPRESA COM SALDO INSUFICIENTE'
        false
      when 'HG'
        #'LOTE DE SERVICO FORA DE SEQUENCIA'
        false
      when 'HH'
        #'LOTE DE SERVICO INVALIDO'
        false
      when 'NA'
        #'CONTA CORRENTE/DV DO FAVORECIDO INVALIDO'
        false
      when 'TA'
        #'LOTE NAO ACEITO - TOTAIS DO LOTE COM DIFERENCA'
        false
      else
        #'IDENTIFICADOR NÃO EXISTENTE OU NÃO RECONHECIDO'
        false
    end
  end
end