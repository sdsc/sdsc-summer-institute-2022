# Preparing for the Summer Institute: Software Requirements
Some sessions require that customized software be installed on **your laptop**. Please perform the following software installations and file downloads prior to the event. <br/> *Note: several of the preparation activities will provide information and guidance on how to install the required software components.*

### Using GitHub@SDSC:<a name="github"></a>

See this quick-start guide: https://github.com/sdsc-hpc-training-org/basic_skills/tree/master/using_github

<hr>

### Scientific visualization with Visit <a name="visit"></a>

Participants who will be attending the Scientific visualization with Visit session should make the following preparations.

* Computer, a mouse with scroll wheel is strongly recommended.

* [Download](https://visit-dav.github.io/visit-website/releases-as-tables/) and install VisIt version 3.1.4 (not the latest). Please do not compile from source unless you are adventurous and ready to troubleshoot for multiple days.
   
* Test run VisIt application on your laptop to make sure it works


* [Download: visit_data_files.zip](http://users.sdsc.edu/~amit/scivis-tutorial/visit_data_files.zip) sample data. Unzip this file and move it to your Home directory.

* [Download: visit3.1.x-expanse-host-profile.zip](http://users.sdsc.edu/~amit/scivis-tutorial/visit3.1.x-expanse-host-profile.zip) VisIt host profile for Expanse.
   Unzip it, then move the xml files (not the unzipped folder) to following location. These locations are not created unless VisIt is started once.

   Linux and Mac: ~/.visit/hosts/ 

   Windows: C:/users/username/Documents/visit/hosts/

* Restart visit to the load the newly added host profiles.
