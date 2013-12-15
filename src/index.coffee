module.exports = class BuffetBrunchCompiler
  brunchPlugin: true
  type: 'template'
  pattern: /(\.buffet\.)|(\.buffet$)/

  constructor: (@config) ->
    
  compile: (data, path, callback) ->
    pattern = @config?.plugins?.buffetBrunch?.pattern
    storageName = @config?.plugins?.buffetBrunch?.variableName || 'buffetBrunch'

    if pattern? && !path.match(pattern)
      return callback(null, data)

    try
      escapedData = data.toString().replace(/\"/g, '\\\"').split('\n').join('\\n\\\n')
      prefix = "#{storageName} = typeof #{storageName} === 'undefined' ? {} : #{storageName};"
      output = prefix + '\n' + storageName + '["' + path + '"] = "' + escapedData + '";\n'
    catch err
      error = err

    callback(error, output)
