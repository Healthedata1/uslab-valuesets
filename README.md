# uslab-valuesets

Creating FHIR Valueset from LRI/LOI/EDOS and ELR NIST Valuesets

1. USE NIST derived ValueSets in folder 20160324_1405_packageR1.1
1. Convert the comments for element location to nodes:
  - e.g.:	`<!--OBX-5.2--> ` to `<MessageLocation>OBX-5.2</MessageLocation>`
	- (Use a simple find and replace function in file to do this
1. Add the files lri-oru, lri-app, and lri-acc to lri after the following modifications made.
   - change names for value set to make unique  added prefix "ORU-"  'ACC-' and 'APP-' to name 'Accept/Application Acknowledgment Conditions'  to make unique  todo is to make DSTU re this.
1. swapped $library-name for $identifier-root
1. Updating the OIDs in NIST Files and the Codesystems to FHIR codesystem urls using the Mapforce file.
   - mapping table for code system created file = code system mapping.xlsx
1. transform to bundle using one of two transforms in the nist-to-lri transforms folder:
   1.single bundle of all resources using: "C:\Users\Eric\Documents\NIST_LOI\Valueset stuff\nist-to-lri transforms\splitter_v2.xslt"
   1. Batch request bundle to load all valuesets into a FHIR server
1. todos
   - fix the List fullURL and id so that will correctly post when doing a batch
   - update some valueset to standard FHIR valuesets ( see codesystem mapping spreadsheet.
   - Convert to STU3
   - Publish in IG format
      - base = `http://hl7.org/fhir/us/lab`
      - extension for usage = `http://hl7.org/fhir/us/lab/StructureDefinition/code-usage`
      -  for missing code systems -  create local example sets for MSH-3-6:

              http://hl7.org/fhir/us/lab/send-app
              http://hl7.org/fhir/us/lab/send-fac
              http://hl7.org/fhir/us/lab/rec-app
              http://hl7.org/fhir/us/lab/rec-fac
   










