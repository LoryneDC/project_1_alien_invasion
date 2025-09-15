import pygame

class Ship:
    """A class to manage the ship."""

    def __init__(self, ai_game):
        """Initialize the ship and set its starting position."""
        self.screen = ai_game.screen
        self.screen_rect = ai_game.screen.get_rect()

        # Load the original ship image
        original_image = pygame.image.load('ship.bmp')

        # 🔹 Scale relative to screen size (smaller: 1/20 of screen width)
        scale_width = self.screen_rect.width // 30
        scale_height = int(original_image.get_height() * (scale_width / original_image.get_width()))

        # Apply scaling
        self.image = pygame.transform.scale(original_image, (scale_width, scale_height))
        self.rect = self.image.get_rect()

        # Start each new ship at the bottom center of the screen.
        self.rect.midbottom = self.screen_rect.midbottom

    def blitme(self):
        """Draw the ship at its current location."""
        self.screen.blit(self.image, self.rect)
