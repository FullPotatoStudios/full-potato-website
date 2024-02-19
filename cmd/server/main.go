package main

import (
	"log"

	"github.com/gofiber/fiber/v2"
	"github.com/gofiber/template/html/v2"
)

func main() {

	engine := html.New("./web/views", ".html")

	app := fiber.New(fiber.Config{
		Views: engine,
	})

	app.Static("/", "./public")

	app.Get("/", func(c *fiber.Ctx) error {
		return c.Render("index", fiber.Map{
			"Title":   "FPS",
			"Message": "Who is a full potato?",
		})
	})

	app.Get("/potato", func(c *fiber.Ctx) error {
		return c.SendString("Yes we are.")
	})

	log.Fatal(app.Listen(":3000"))
}
