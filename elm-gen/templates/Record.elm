module {{moduleBase}}.{{template}}.{{moduleName}} exposing (..)

{-| This module contains the {{moduleName}} {{template}}.

    type alias {{moduleName}} =
{{#fields}}
{{#if @first}}        { {{name}} : {{type}}
{{else}}        , {{name}} : {{type}}
{{/if}}
{{/fields}}
        }


# Type

@docs {{moduleName}}


# Getter

@docs {{#fields}}{{#if @first}}{{else}}, {{/if}}get{{capitalize name}}{{/fields}}


# Setter

@docs {{#fields}}{{#if @first}}{{else}}, {{/if}}set{{capitalize name}}{{/fields}}


# Mapper

@docs {{#fields}}{{#if @first}}{{else}}, {{/if}}map{{capitalize name}}{{/fields}}

{{#if withJsonEncoder}}
# Serialization

{{else}}
{{#if withJsonDecoder}}
# Serialization

{{/if}}
{{/if}}
{{#if withJsonEncoder}}@docs encoder{{/if}}
{{#if withJsonDecoder}}@docs decoder{{/if}}

-}

{{#imports}}
import {{.}}
{{/imports}}
{{#if withJsonEncoder}}import Json.Encode as E{{/if}}
{{#if withJsonDecoder}}import Json.Decode as D{{/if}}

-- This is a generated file. DO NOT CHANGE ANYTHING IN HERE.

-------------------------------------------------------------------------------
-- TYPE
-------------------------------------------------------------------------------

{-| {{moduleName}} record
-}
type alias {{moduleName}} =
{{#fields}}
{{#if @first}}    { {{name}} : {{type}}
{{else}}    , {{name}} : {{type}}
{{/if}}
{{/fields}}
    }



-------------------------------------------------------------------------------
-- GETTER
-------------------------------------------------------------------------------


{{#fields}}
{-| Get the value of the {{name}} field.

    get{{capitalize name}} : {{../moduleName}} -> {{type}}
    get{{capitalize name}} =
        .{{name}}

-}
get{{capitalize name}} : {{../moduleName}} -> {{type}}
get{{capitalize name}} =
    .{{name}}


{{/fields}}


-------------------------------------------------------------------------------
-- SETTER
-------------------------------------------------------------------------------


{{#fields}}
{-| Set the value of the {{name}} field.

    set{{capitalize name}} : {{type}} -> {{../moduleName}} -> {{../moduleName}}
    set{{capitalize name}} {{name}} {{decapitalize ../moduleName}} =
        { {{decapitalize ../moduleName}} | {{name}} = {{name}} }

-}
set{{capitalize name}} : {{type}} -> {{../moduleName}} -> {{../moduleName}}
set{{capitalize name}} {{name}} {{decapitalize ../moduleName}} =
    { {{decapitalize ../moduleName}} | {{name}} = {{name}} }


{{/fields}}

-------------------------------------------------------------------------------
-- MAPPER
-------------------------------------------------------------------------------


{{#fields}}
{-| Map the value of the {{name}} field.

    map{{capitalize name}} : ({{type}} -> {{type}}) -> {{../moduleName}} -> {{../moduleName}}
    map{{capitalize name}} fun {{decapitalize ../moduleName}} =
        { {{decapitalize ../moduleName}} | {{name}} = fun {{decapitalize ../moduleName}}.{{name}} }

-}
map{{capitalize name}} : ({{type}} -> {{type}}) -> {{../moduleName}} -> {{../moduleName}}
map{{capitalize name}} fun {{decapitalize ../moduleName}} =
    { {{decapitalize ../moduleName}} | {{name}} = fun {{decapitalize ../moduleName}}.{{name}} }


{{/fields}}


{{#if withJsonEncoder}}
-------------------------------------------------------------------------------
-- SERIALIZATION
-------------------------------------------------------------------------------

{{else}}
{{#if withJsonDecoder}}
-------------------------------------------------------------------------------
-- SERIALIZATION
-------------------------------------------------------------------------------

{{/if}}
{{/if}}
{{#if withJsonEncoder}}
{-| Json encoder for {{moduleName}}
-}
encoder :  {{moduleName}} -> E.Value
encoder {{decapitalize moduleName}} =
     E.object
{{#fields}}
        {{#if @first}}[ {{else}}, {{/if}}("{{name}}",({{jsonEncoder}}) {{decapitalize ../moduleName}}.{{name}} )
{{/fields}}
        ]
{{/if}}

{{#if withJsonEncoder}}
{-| Json decoder for {{moduleName}}
-}
decoder : D.Decoder {{moduleName}}
decoder =
    D.succeed
        (\ {{#fields}}{{name}} {{/fields}}->
{{#fields}}
{{#if @first}}            { {{name}} = {{name}}
{{else}}            , {{name}} = {{name}}
{{/if}}
{{/fields}}
            }
        )
{{#fields}}
            |> D.andThen (\fun ->  D.map fun ({{jsonDecoder}}) )
{{/fields}}
{{/if}}