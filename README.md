  
# AI arb file generator

> Using OpenAI to translate words/sentence to generate and populate arb files respectfully
> Using AI to generate an ARB file and populate it with (provided words/sentences and their translated counterparts).

## Getting started
inside bin/translation_gen.dart add your english words and or sentences in the List values 

    // use "" double quotes for values
    // example
    List<String> values = ["Hello" ,"Good Morning!",];

then run the bellow code, make sure to add your openAI token
dart run --define=OPENAI_TOKEN='<YOUR_OPENAI_TOKEN>'