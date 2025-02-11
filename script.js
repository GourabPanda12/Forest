 $(document).ready(function(){
	 
	  $('#sidebar a').click(function (e) {
               //  e.preventDefault();  // Prevent the default action of the anchor

                 var hrefValue = $(this).attr('href');  // Get the href attribute value
                 console.log('Clicked link href:', hrefValue);  // Log the href value

                 // Find the top-most sub-menu and set it to display block
                localStorage.setItem('clckjlnkd',hrefValue) 
             });
	 
	 
			  var existsx = localStorage.getItem('clckjlnkd') ;
			//alert(existsx);
            let found = false;
let ghn = '';
            $('#sidebar a').each(function() {
				//alert($(this).attr('href'));
                if ($(this).attr('href') == existsx) {
                    found = true;
					ghn=$(this);
					//alert($(this).attr('href'));
                    return false; // break the loop
                }
            });

            if (found) {
				
				  var $currentSubMenu = $(ghn).closest('ul');
				//alert($currentSubMenu.html());
                 var $topMostSubMenu = $currentSubMenu;
				if ($currentSubMenu.attr('class') !== "nano-content") {
					//alert();
					    while ($topMostSubMenu.parent().closest('.sub-menu').length > 0) {
					// $topMostSubMenu.css('background-color', '#6be964');
					// $topMostSubMenu.css('display', 'block');
                     $topMostSubMenu = $topMostSubMenu.parent().closest('.sub-menu');
                 }
$currentSubMenu.css('display', 'block');
                 $topMostSubMenu.css('display', 'block');
				}
				else
				{
					
					$currentSubMenu = $(ghn).closest('.sub-menu');
					//alert($currentSubMenu);
					$currentSubMenu.css('background-color', '#6be964');
				$(ghn).css({
  "color": "black",
  "font-weight": "700"
});
				}

            
				// $topMostSubMenu.css('background-color', '#6be964');
               // alert('Found dossiervchl.aspx');
            } else {
               // alert('dossiervchl.aspx not found');
            }
        });

const allSideMenu = document.querySelectorAll('#sidebar .side-menu.top li a');

allSideMenu.forEach(item=> {
	const li = item.parentElement;

	item.addEventListener('click', function () {
		allSideMenu.forEach(i=> {
			i.parentElement.classList.remove('active');
		})
		li.classList.add('active');
	})
});



const menuBar = document.querySelector('#content nav .bx.bx-menu');


const sidebar = document.getElementById('sidebar');

menuBar.addEventListener('click', function () {

	sidebar.classList.toggle('hide');

})



const searchButton = document.querySelector('#content nav form .form-input button');
const searchButtonIcon = document.querySelector('#content nav form .form-input button .bx');
const searchForm = document.querySelector('#content nav form');

searchButton.addEventListener('click', function (e) {
	if(window.innerWidth < 576) {
		e.preventDefault();
		searchForm.classList.toggle('show');
		if(searchForm.classList.contains('show')) {
			searchButtonIcon.classList.replace('bx-search', 'bx-x');
		} else {
			searchButtonIcon.classList.replace('bx-x', 'bx-search');
		}
	}
})





if(window.innerWidth < 768) {
	sidebar.classList.add('hide');
} else if(window.innerWidth > 576) {
	searchButtonIcon.classList.replace('bx-x', 'bx-search');
	searchForm.classList.remove('show');
}


window.addEventListener('resize', function () {
	if(this.innerWidth > 576) {
		searchButtonIcon.classList.replace('bx-x', 'bx-search');
		searchForm.classList.remove('show');
	}
})



const switchMode = document.getElementById('switch-mode');

switchMode.addEventListener('change', function () {
	if(this.checked) {
		document.body.classList.add('dark');
	} else {
		document.body.classList.remove('dark');
	}
})

