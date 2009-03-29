package MixiApp::Controller::Root;

use strict;
use warnings;
use parent 'Catalyst::Controller';

#
# Sets the actions in this controller to be registered with no prefix
# so they function identically to actions created in MyApp.pm
#
__PACKAGE__->config->{namespace} = '';

=head1 NAME

MixiApp::Controller::Root - Root Controller for MixiApp

=head1 DESCRIPTION

[enter your description here]

=head1 METHODS

=cut

=head2 index

=cut

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;
    $c->stash->{template} = 'index.tt';
    my $claimed_uri = $c->req->params->{openid_identifier};
    if ($c->authenticate({openid_identifier => $claimed_uri})) {
        $c->stash->{success} = 1;
        #$c->res->redirect($c->uri_for('/'));
    }
    else {
        #$c->response->body('fail');
        #$c->response->status(401);
    }

}

sub default :Path {
    my ( $self, $c ) = @_;
    $c->response->body( 'Page not found' );
    $c->response->status(404);
}

=head2 end

Attempt to render a view, if needed.

=cut

sub end : ActionClass('RenderView') {}

=head1 AUTHOR

Kensuke Kaneko

=head1 LICENSE

This library is free software, you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;
