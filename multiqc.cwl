cwlVersion: v1.2
class: CommandLineTool

label: multiqc 1.14
doc: | 
  Aggregate results from bioinformatics analyses across many samples 
  into a single report.

requirements:
  DockerRequirement:
    dockerPull: ewels/multiqc:v1.14

baseCommand: multiqc

arguments: 
  - prefix: "--outdir"
    valueFrom: $(runtime.outdir)
  - valueFrom: "--zip-data-dir"
  - valueFrom: "--no-megaqc-upload"
  - valueFrom: "--profile-runtime"
    

inputs:
  report_name:
    label: Report Name
    type: string
    doc: Name for output report html and corresponding zip archive
    inputBinding:
      prefix: "--filename"

  prefix_dirs:
    label: Prefix dir to samplename
    type: boolean?
    doc: |
      (Optional) When same sample is processed in different ways, enable this 
      parameter in order to prepend filepath to samplename.
    inputBinding: 
      prefix: "--dirs"

  dir_depth:
    label: Directory depth 
    type: int
    default: 1
    inputBinding: 
      prefix: "--dirs-depth"
    doc: |
      Use with prefix dirs to specify which directory name to prepend. 
      Positive integers will add the specified number of directories at the 
      end of the path. Negative integers will take the specified number of 
      directories from the start of the path. 

  input_dir:
    label: Input directory
    type: Directory
    inputBinding: 
      position: 200
    doc: Directory to search for analysis logs and metrics files. 


outputs:
  multiqc_zip:
    type: File
    outputBinding:
      glob: $(inputs.report_name)_data.zip
  multiqc_html:
    type: File
    outputBinding:
      glob: $(inputs.report_name).html
