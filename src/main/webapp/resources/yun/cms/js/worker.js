/**
 * 
 */

self.onmessage = function( e ) {
    console.log( 'Worker가 받은 메시지 ', e.data );
	loop();
		
};

function loop() {
	postMessage( "실행" );
	
	setTimeout( function() {
    	loop();
    }, 500 );	
}
