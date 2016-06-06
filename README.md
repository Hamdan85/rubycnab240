# RubyCnab240

A Gem RubyCnab240 permite criar arquivos de remessa de pagamentos no formato RubyCnab240 para o Banco do Brasil (por enquanto) segundo as normas da Febraban

## Instalação

Adicione ao seu Gemfile

```ruby
gem 'rubycnab240'
```

Depois basta requerir a mesma

```ruby
require 'rubycnab240'
```

Ou instale você mesmo:

    $ gem install rubycnab240

## Uso

O arquivo de documentação de referencia encontra-se na pasta Docs. Porém, segue um exemplo funcional abaixo:

```ruby
#crie o arquivo de remessa

r = RubyCnab240::Arquivo.new({
                                :codigo_do_banco_na_compensacao => '000', #codigo do seu banco
                                :tipo_de_inscricao_da_empresa => '2', #1 para CPF, 2 para CNPJ
                                :numero_de_inscricao_da_empresa => '00000000000000', #CNPJ
                                :codigo_do_convenio_do_banco => '000000000', #codigo do convenio do banco
                                :agencia_mantenedora_da_conta => '00000', #sua agencia
                                :digito_verificador_da_agencia => '0', #digito verificador da agencia
                                :numero_da_conta_corrente => '000000000000', #numero da conta corrente
                                :digito_verificador_da_conta => '0', #digito verificador da conta
                                :nome_da_empresa => '______________________________', #nome da empresa
                                :nome_do_banco => '___________________', #nome do banco
                                :codigo_remessa_retorno => '1', #verificar documentação febraban (pasta docs)
                                :numero_sequencial_de_arquivo => '3', #numero sequencial do arquivo (verificar documentaçao pasta docs)
                                :para_uso_reservado_da_empresa => 'texto', #(verificar documentaçao pasta docs)
                                :data_dos_pagamentos => Date.today #data dos pagamentos em 
                            })

#crie um lote para pagamentos externos ao banco

lote_externo = RubyCnab240::Arquivo::Lote.new({
                                    :forma_de_lancamento => 'EXTERNO',
                                    :codigo_do_banco_na_compensacao => '000', #codigo identificador de banco exceto banco do brasil                                    
                                    :codigo_remessa_retorno => '1',
                                    :numero_sequencial_de_arquivo => '3',
                                    :para_uso_reservado_da_empresa => '', #texto reservado para empresa
                                    :campos_opcionais_de_endereco => '' #(verificar documentaçao pasta docs)
                                  })
#crie um lote para pagamentos internos ao banco

lote_interno = RubyCnab240::Arquivo::Lote.new({
                                    :forma_de_lancamento => 'INTERNO',
                                    :codigo_do_banco_na_compensacao => '001', #001 para banco do brasil                                 
                                    :codigo_remessa_retorno => '1',
                                    :numero_sequencial_de_arquivo => '3',
                                    :para_uso_reservado_da_empresa => '', #texto reservado para empresa
                                    :campos_opcionais_de_endereco => '' #(verificar documentaçao pasta docs)
                                  })

#adicione pagamentos dentro do lote (somentes com favorecidos de outros bancos que nao o banco do brasil)

lote_externo << {
    :codigo_do_banco_favorecido => '000', #codigo do banco do favorecido
    :agencia_mantenedora_da_conta_favorecida => '0000', #agencia do favorecido
    :digito_verificador_da_agencia => '0',
    :numero_da_conta_corrente => '',
    :digito_verificador_da_conta => '0',
    :nome_do_favorecido => 'NOME DO FAVORECIDO',
    :numero_doc_atribuido_para_empresa => '000000000001', #a ser utilizaro para identificação posterior
    :valor_do_pagamento => '1000', #valor do pagamento em centavos
    :outras_informacoes => 'OUTRAS INFORMACOES',
    :tipo_de_inscricao_do_favorecido => '1', # 1 para CPF e 2 para CNPJ
    :numero_de_inscricao_do_favorecido => '00000000000', #CPF OU CNPJ
    :complemento_tipo_de_servico => '1' #(verificar documentaçao pasta docs)
}

#adicione pagamentos dentro do lote (somentes com favorecidos do banco do brasil)

lote_externo << {
    :codigo_do_banco_favorecido => '001', #codigo do banco do favorecido (001 por ser o banco do brasil)
    :agencia_mantenedora_da_conta_favorecida => '0000', #agencia do favorecido
    :digito_verificador_da_agencia => '0',
    :numero_da_conta_corrente => '',
    :digito_verificador_da_conta => '0',
    :nome_do_favorecido => 'NOME DO FAVORECIDO',
    :numero_doc_atribuido_para_empresa => '000000000001', #a ser utilizaro para identificação posterior
    :valor_do_pagamento => '1000', #valor do pagamento em centavos
    :outras_informacoes => 'OUTRAS INFORMACOES',
    :tipo_de_inscricao_do_favorecido => '1', # 1 para CPF e 2 para CNPJ
    :numero_de_inscricao_do_favorecido => '00000000000', #CPF OU CNPJ
    :complemento_tipo_de_servico => '1' #(verificar documentaçao pasta docs)
}

#adicione os lotes aos arquivo

r << lote_interno
r << lote_externo

#crie o arquivo a ser salvo

file = File.open('nome_do_arquivo_de_remessa.rem', "w+")

#salve o arquivo

r.save_to_file(file)
```

## Contribua

Report de Bugs serão bem vindos no GitHub em https://github.com/Hamdan85/rubycnab240. Fique a vontade para contribuir com mais funcionalidades.

