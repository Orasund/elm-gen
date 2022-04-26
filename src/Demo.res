%%raw(`
const Handlebars = require("handlebars")
const fs = require("fs")
`)

%%raw(`const elmGen = "elm-gen"`)

%%raw(`

//Register additional functions
Handlebars.registerHelper('capitalize', function (aString) {
    return aString[0].toUpperCase() + aString.substring(1);
})
Handlebars.registerHelper('decapitalize', function (aString) {
    return aString[0].toLowerCase() + aString.substring(1);
})
`)

let constructData = (moduleBase, moduleName, template, baseData) => {
  let data = baseData
  data["moduleBase"] = moduleBase
  data["moduleName"] = moduleName
  data["template"] = template
  data
}

%%raw(`
function generateModule(moduleBase,moduleName) {
    return module => {
        //construct data
        const data = constructData(moduleBase,moduleName,module[0], module[1])
        console.log(data)

        try {
            //read template
            const templateData = fs.readFileSync("." + elmGen + "/templates/" + data.template + ".elm", "utf8")
        
            //compile files
            const template = Handlebars.compile(templateData,{strict : true})
            const output = template(data)
            const dir = ("." + elmGen + "/generated/") + data.moduleBase.replace(".","/") + ("/" + data.template)
            const generatedPath =  dir + "/" + data.moduleName  + ".elm"

            //create folder structure
            if (!fs.existsSync(dir)) fs.mkdirSync(dir, { recursive: true });
            
            //create file
            fs.writeFileSync(generatedPath, output, {flag : "w+"})
        } catch (err) {
            console.error(err)
        }
    }
}`)

%%raw(`
try { 
    //Read json structure
    const json = JSON.parse(fs.readFileSync(elmGen + ".json", "utf8"))
    Object.entries(json.modules)
        .forEach(modules => {
            const moduleName = modules[0]
            Object.entries(modules[1])
                .forEach(generateModule(json.moduleBase,moduleName))
        });
} catch (err) {
    console.error(err)
}
`)
