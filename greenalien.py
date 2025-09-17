import pygame

class GreenAlien:
    """A class to manage the green alien."""

    def __init__(self, ai_game):
        """Initialize the alien and set its starting position."""
        self.screen = ai_game.screen
        self.screen_rect = ai_game.screen.get_rect()

        # Load the original alien image
        original_image = pygame.image.load('green_alien.bmp')

        # 🔹 Scale relative to screen size (e.g., 1/15 of screen width)
        scale_width = self.screen_rect.width // 20
        scale_height = int(original_image.get_height() * (scale_width / original_image.get_width()))

        # Apply scaling
        self.image = pygame.transform.scale(original_image, (scale_width, scale_height))
        self.rect = self.image.get_rect()

        # Start each new alien at the middle top of the screen.
        self.rect.midtop = self.screen_rect.midtop
    
    def blitme(self):
        """Draw the alien at its current location."""
        self.screen.blit(self.image, self.rect)

